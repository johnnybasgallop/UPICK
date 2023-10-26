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
    
    @Binding var isLoading : Bool
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ScrollView{
            
            GenreSelect(Genre: $Genre)
            
            YearSliders(minYear: $minYear, maxYear: $maxYear)
            
            
        }
        .onDisappear{
                
            isLoading = true
            
            apiController.getData(FilterState : Filter(genres: Genre, services: ["netflix"], minYear: minYear, maxYear: maxYear, isMovie: true)) { error in
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
            isSelected.toggle()
            
            Genre[0] = "\(id)"
            
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



