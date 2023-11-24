//
//  FilterView.swift
//  UPick
//
//  Created by johnny basgallop on 26/09/2023.
//

import SwiftUI
import WrappingHStack

struct FilterView: View {
    @State private var query: String = ""
    @StateObject var apiController = APIController()
    @Binding var minYear : Int
    @Binding var maxYear : Int
    @Binding var example : Bool
    @Binding var movies : [Movie]
    @Binding var Genre : [String]
    @Binding var streamingServices : [String]
    @Binding var isMovie : Bool
    @Binding var isLoading : Bool
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ScrollView{
            
            streamingServiceSelect(streamingServices: $streamingServices)
            
            GenreSelect(Genre: $Genre)
            
            YearSliders(minYear: $minYear, maxYear: $maxYear)
            
            
        }
        .onDisappear{
            
            
            
            var servicesConcat : String = ""
            var genreConcat : String = ""
            
            
            for service in streamingServices {
                if service != streamingServices.last{
                    var service2 = service + ","
                    servicesConcat.append(service2)
                }
                
                else{
                    servicesConcat.append(service)
                }
            }
            
            
            
            for genre in Genre {
                if genre != Genre.last {
                    var genre2 = genre + ","
                    genreConcat.append(genre2)
                }
                
                else {
                    genreConcat.append(genre)
                }
            }
            
            
            
            if servicesConcat.count > 1 {
                
                isLoading = true
                
                
                
                apiController.getData(FilterState : Filter(genres: [genreConcat], services: [servicesConcat], minYear: minYear, maxYear: maxYear, isMovie: isMovie), cursor: "") { error in
                    if let error = error {
                        print("Error: \(error)")
                    } else {
                        // The data retrieval and processing are complete, but no movie data is returned here
                        
                        
                        self.movies = apiController.Movies
                        print("Data retrieval and processing completed")
                        
                        isLoading = false
                        
                    }
                }
                
                example.toggle()
                
            }
        }
        }
    }





struct streamingServiceSelect : View {
    
    @Binding var streamingServices : [String]
    
    let StreamingServices : [[String: Any]] = [
        
        ["name" : "netflix", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/netlfix.jpeg?alt=media&token=1f0f7a76-76fc-40b8-8bd8-c8e026850c11&_gl=1*3vtr0x*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzU0MTcuNTUuMC4w"],
        
        ["name" : "prime.subscription", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/primevideo-removebg-preview.png?alt=media&token=375c6cfe-e6f7-474a-993a-aebd391ee566&_gl=1*tnfjl*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzUxNzMuNTMuMC4w"],
        
        ["name" : "apple.subscription", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/atv.jpeg?alt=media&token=bc11d27b-c7e7-4021-a47b-020dfd607e47&_gl=1*5l3ay4*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzQ5OTQuOC4wLjA."],
        
        ["name" : "iplayer", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/bbcIplayer.png?alt=media&token=e00acdea-ac37-4543-945f-bd4fe9fda281&_gl=1*1xwygs6*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzUyNjguNTUuMC4w"],
        
        ["name" : "disney.subscription", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/disney.jpeg?alt=media&token=3c727285-eaf2-4e41-bc6b-4176b5126e47&_gl=1*50k677*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzYwOTkuNTMuMC4w"],
        
        ["name" : "now", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/nowtv.png?alt=media&token=374042d7-d2a2-4244-b442-92b976b05829&_gl=1*of3jr9*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTE0MDg3MC4xNC4xLjE2OTkxNDA4NzguNTIuMC4w"],
        
        ["name" : "paramount.subscription", "img": "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/paramountplus.jpeg?alt=media&token=c39bd8f0-f1f5-4d53-ba6d-4118c241e2ec&_gl=1*7hkrz2*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzYwMDMuNDEuMC4w"],
        
    ]
    
    var body: some View {
        VStack{
            HStack{
                Text("Services")
                    .font(.system(size: 35, weight: .bold
                                 ))
                    .padding()
                Spacer()
            }
            WrappingHStack(StreamingServices, id: \.self){ service in
                ServiceButton(streamingServices: $streamingServices, text: service["name"] as! String, img: service["img"] as! String)
            }
            .padding(20)
            .frame(width: screenWidth * 0.95)
            Divider()
        }
    }
}


struct ServiceButton: View {
    @State var isSelected: Bool = false
    @Binding var streamingServices: [String]
    var text: String
    var img: String
    
    var body: some View {
        Button(action: {
            
            if streamingServices.contains(text) == false {
                streamingServices.append(text)
            }
            
            else if streamingServices.contains(text) {
                streamingServices.removeAll { $0 == text }
            }
            
            isSelected.toggle()
            
        }) {
            // Image should be placed after the background overlay
            AsyncImage(url: URL(string: img)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                //                    .padding()
                    .cornerRadius(8)
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .background(streamingServices.contains(text) ? Color.black : Color.white)
            .cornerRadius(13)
            
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(Color.black, lineWidth: 2)
                
                    .cornerRadius(13)
            )
        }
        .padding(.horizontal, 2)
        .padding(.vertical, 5)
    }
}




struct GenreSelect : View {
    
    @Binding var Genre : [String]
    
    let movieGenres: [[String: Any]] = [
        ["name": "Action", "id": 28],
        ["name": "Adventure", "id": 12],
        ["name": "Animation", "id": 16],
        ["name": "Comedy", "id": 35],
        ["name": "Historical", "id": 36],
        ["name": "Drama", "id": 18],
        ["name": "Fantasy", "id": 14],
        ["name": "Western", "id": 37],
        ["name": "Horror", "id": 27],
        ["name": "Mystery", "id": 9648],
        ["name": "Crime", "id": 80],
        ["name": "Science Fiction", "id": 878],
        ["name": "Thriller", "id": 53],
        ["name": "Romance", "id": 10749]
    ]
    
    
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Genres")
                    .font(.system(size: 35, weight: .bold
                                 ))
                    .padding()
                Spacer()
            }
            WrappingHStack(movieGenres, id: \.self) { movie in
                GenreBox(Genre: $Genre, text: movie["name"] as! String, id: movie["id"] as! Int)
            }
            .padding(20)
            .frame(width: screenWidth * 0.95)
            Divider()
            
        }
        
    }
}



struct GenreBox : View {
    @StateObject var apiController = APIController()
    @Binding var Genre : [String]
    var text : String
    var id : Int
    
    @State var isSelected : Bool = false
    
    
    var body: some View {
        
        
        
        Button(action: {
            
            if Genre.contains("\(id)") == false {
                Genre.append("\(id)")
            }
            
            else if Genre.contains("\(id)") {
                Genre.removeAll{$0 == "\(id)"}
            }
            
            isSelected.toggle()
            
            
            
        }) {
            Text(text)
                .foregroundColor(Genre.contains("\(id)") ? .white : .black)
                .padding()
                .background(Genre.contains("\(id)") ? .black : .white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 13)
                        .stroke(Color.black, lineWidth: 2) // Add rounded border
                )
        }
        .padding(.horizontal, 2)
        .padding(.vertical, 5)
        
    }
}


struct YearSliders : View {
    @StateObject var apiController = APIController()
    
    @Binding var minYear : Int
    @Binding var maxYear : Int
    
    
    
    
    var body: some View {
        VStack{
            HStack{
                Text("Release year")
                    .font(.system(size: 35, weight: .bold
                                 ))
                
                    .padding()
                Spacer()
            }
            HStack{
                Picker("Min year", selection: $minYear) {
                    ForEach(1920..<2024, id: \.self ){ year in
                        Text(String(year)).tag(String(year))
                    }
                }
                .onChange(of: minYear){change in
                    minYear = change
                }
                .pickerStyle(.wheel)
                .frame(width: screenWidth / 2.2, height: 150)
                
                
                Picker("Min year", selection: $maxYear) {
                    ForEach(minYear..<2024, id: \.self){ year in
                        
                        Text(String(year)).tag(String(year))
                    }
                }
                .onChange(of: maxYear){change in
                    maxYear = change
                }
                .pickerStyle(.wheel)
                .frame(width: screenWidth / 2.2, height: 150)
                
            }.padding(.vertical, 20)
                .offset(y: -10)
            
            Divider()
        }
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(
            minYear: .constant(2000),
            maxYear: .constant(2022),
            example: .constant(true),
            movies: .constant([]),
            Genre: .constant(["28", "35"]),
            streamingServices: .constant(["netflix"]),
            isMovie: .constant(true), 
            isLoading: .constant(false)
        )
        
    }
}

