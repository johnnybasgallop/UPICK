//
//  LocalStorage.swift
//  UPick
//
//  Created by johnny basgallop on 08/11/2023.
//

import Foundation


class LocalStorage: ObservableObject{
    
    private static var myKey = "key"
    
    @Published var movies: [Movie] = []
    
    
    func setMovies(movies: [Movie], key: String, completion: @escaping (Error?) -> Void){
        
        do{
            let encoder = JSONEncoder()
            let data =  try encoder.encode(movies)
            UserDefaults.standard.set(data, forKey: key)
            
            self.movies = movies
        }
        catch{
            print("error encoding data")
        }
        
        
        
        completion(nil)
    }
    
    
    func AppendMovie(bookmarkedMovies: [Movie] ,movie: Movie ,key: String, completion: @escaping (Error?) -> Void){
        
        var newMovies = bookmarkedMovies
        newMovies.append(movie)
        
        setMovies(movies: newMovies, key: "bookmarked"){error in
            if let error = error{
                print(error)
            }
            
            else{
                completion(nil)
            }
            
        }
            
        completion(nil)
    }
    
    
    func deleteMovie(movie: Movie, key: String, completion: @escaping (Error?) -> Void){
        if let data = UserDefaults.standard.data(forKey: key){
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                var movies = try decoder.decode([Movie].self, from: data)
                
                movies.removeAll{$0 == movie}
                
                
                setMovies(movies: movies, key: "bookmarked"){error in
                    if let error = error {
                        print(error)
                    }
                    else{
                        completion(nil)
                    }
                }
                
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
            
        }
    }
    
    
    func getMovies(key: String, completion: @escaping (Error?) -> Void) {
        if let data = UserDefaults.standard.data(forKey: key){
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Note
                let movies = try decoder.decode([Movie].self, from: data)
                
                self.movies = movies
                completion(nil)
                
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            
            
        }
        
        
    }
    
    
    
}
