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
            
            
        }.searchable(text: $query, prompt: Text("search"))
    }
}


struct GenreSelect : View {
    
    let movieGenres = [
        "Action",
        "Adventure",
        "Animation",
        "Comedy",
        "Historical",
        "Drama",
        "Fantasy",
        "Wesrtern",
        "Horror",
        "Mystery",
        "Crime",
        "Science Fiction",
        "Thriller",
        "Romance"
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
                GenreBox(text: movie)
            }
            .padding(.bottom, 20)
            .frame(width: screenWidth * 0.95)
            Divider()
            
        }
        
    }
}



struct GenreBox : View {
    @StateObject var apiController = APIController()
    
    var text : String
    
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
    @State var minYear : Int = 1920
    @State var maxYear : Int = 2023
    
    
    var body: some View {
        VStack{
            HStack{
                Picker("Min year", selection: $minYear) {
                    ForEach(1920..<2024){ year in
                        Text(String(year)).tag(String(year))
                    }
                }.pickerStyle(.wheel)
                    .frame(width: screenWidth / 2.2, height: 150)
                
                
                Picker("Min year", selection: $maxYear) {
                    ForEach(1920..<2024){ year in
                        
                        Text(String(year)).tag(String(year))
                    }
                }.pickerStyle(.wheel)
                    .frame(width: screenWidth / 2.2, height: 150)
                
            }.padding(.vertical, 30)
        }
        
    }
}



struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
