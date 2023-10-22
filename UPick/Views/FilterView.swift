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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView{
            
            GenreSelect()
            
            YearSliders()
            
            
        }
    }
}


struct GenreSelect : View {
    
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
                GenreBox(text: movie["name"] as! String, id: movie["id"] as! Int)
            }
            .padding(20)
            .frame(width: screenWidth * 0.95)
            Divider()
            
        }
        
    }
}



struct GenreBox : View {
    @StateObject var apiController = APIController()
    
    var text : String
    var id : Int
    
    @State var isSelected : Bool = false
    
    
    var body: some View {
        
        Button(action: {
            isSelected.toggle()
            
            
        }) {
            Text(text)
                .foregroundColor(isSelected ? .white : .black)
                .padding()
                .background(isSelected ? Color.black : Color.white)
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
    @State var minYear : Int = 1980
    @State var maxYear : Int = 2023
    
    
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
                }.pickerStyle(.wheel)
                    .frame(width: screenWidth / 2.2, height: 150)
                
                
                Picker("Min year", selection: $maxYear) {
                    ForEach(minYear..<2024, id: \.self){ year in
                        
                        Text(String(year)).tag(String(year))
                    }
                }.pickerStyle(.wheel)
                    .frame(width: screenWidth / 2.2, height: 150)
                
            }.padding(.vertical, 20)
                .offset(y: -10)
            
            Divider()
        }
        
    }
}



struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
