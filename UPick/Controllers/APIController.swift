//
//  APIController.swift
//  UPick
//
//  Created by johnny basgallop on 17/09/2023.
//

import Foundation
import Alamofire

var tmdbAPIKey : String = "15d2ea6d0dc1d476efbca3eba2b9bbfb"

class APIController : ObservableObject {
    
   
    @Published var Movies : [Movie] = []
    @Published var MovieNames : [String] = []
    @Published var PosterPaths : [String] = []
    
    let apiKey = "YOUR_TMDB_API_KEY"
    var movieNames = ["The Matrix", "Inception", "Avatar"]
    
    let APIKey : String = "3ca296bda3msh869858e0f53d7a6p1c0a7bjsn048eee98983c"
    let APIHost : String = "streaming-availability.p.rapidapi.com"
    
    
    
    let headers : HTTPHeaders = [
        "X-RapidAPI-Key": "3ca296bda3msh869858e0f53d7a6p1c0a7bjsn048eee98983c",
        "X-RapidAPI-Host": "streaming-availability.p.rapidapi.com"
    ]
    
    
    func getData(FilterState : Filter ,completion: @escaping (Error?) -> Void) {
        let url = "https://streaming-availability.p.rapidapi.com/search/filters"
        
        let Params: [String: String] = [
            "services": "\(FilterState.services[0])",
            "country": "gb",
            "genres": "\(FilterState.genres[0])",
            "show_type": FilterState.isMovie ? "movie" : "series",
            "year_min" : "\(FilterState.minYear)",
            "year_max" : "\(FilterState.maxYear)",
            "show_original_language": "en"
        ]
        
        AF.request(url, method: .get, parameters: Params, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let results = json["result"] as? [[String: Any]] {
                        
                        
                        
                        
                        let dispatchGroup = DispatchGroup()
                        
                        for result in results {
                            
                            var serviceArray : [String] = []
                            
                            if let originalTitle = result["originalTitle"] as? String,
                               let streamingInfo = result["streamingInfo"] as? [String: Any],
                               let gbInfo = streamingInfo["gb"] as? [[String: Any]] {
                                
                                for serviceInfo in gbInfo {
                                       if let serviceName = serviceInfo["service"] as? String {
                                           if serviceArray.contains(serviceName) == false {
                                               serviceArray.append(serviceName)
                                           }
                                         
                                    }
                                }
                                
                                
                                dispatchGroup.enter()
                                
                                serviceArray.sort()
                                
                                self.getMovieInfo(movieName: originalTitle, apiKey: "15d2ea6d0dc1d476efbca3eba2b9bbfb", streamingInfo: serviceArray) { movie in
                                    if let movie = movie {
                                        self.Movies.append(movie)
                                        print(movie.StreamingServices)
                                    }
                                    dispatchGroup.leave()
                                }
                            }
                        }
                        
                        dispatchGroup.notify(queue: .main) {
                            // Completion handler is called when all requests are complete
                            completion(nil)
                        }
                    }
                case .failure(let error):
                    // Handle the error here
                    completion(nil)
                }
            }
    }
    
    
    
    func getMovieInfo(movieName: String, apiKey: String, streamingInfo : [String], completion: @escaping (Movie?) -> Void) {
        // Encode the movie name for the URL using URLComponents
        var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie")
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: movieName)
        ]
        
        guard let url = components?.url else {
            completion(nil)
            return
        }
        
        
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300) // Accept only 2xx status codes
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], let results = json["results"] as? [[String: Any]], let firstResult = results.first {
                        
                        if let posterPath = firstResult["poster_path"] as? String,
                           let overview = firstResult["overview"] as? String {
                            
                            // Create a Movie instance with the fetched data
                            let movie = Movie(title: movieName, img: posterPath, description: overview, StreamingServices: streamingInfo )
                            
                            completion(movie)
                        } else {
                            completion(nil) // Poster path or overview not found
                        }
                    } else {
                        completion(nil) // No results found
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil) // Error occurred
                }
            }
    }






    // Example usage

    
}
