//
//  TopBar.swift
//  UPick
//
//  Created by johnny basgallop on 24/09/2023.
//

import SwiftUI

struct TopBar : View {
    @Binding var example : Bool
    @Binding var movies : [Movie]
    @Binding var isLoading : Bool
    @Binding var Genre : [String]
    @Binding var streamingServices : [String]
    @Binding var minYear : Int
    @Binding var maxYear : Int
    @Binding var isMovie : Bool
    var body: some View {
        
        HStack {
            Text("UPick.")
                .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 40))
            
            
            Spacer()
            FilterButton(example: $example, movies: $movies, isLoading: $isLoading, Genre: $Genre ,streamingServices: $streamingServices, isMovie: $isMovie, minYear: $minYear, maxYear: $maxYear)
        }
        .padding(.horizontal, 30)
        .frame(height: screenHeight * 0.07)
        
        
        
    }
}


struct FilterButton : View {
    @State private var showingFilter : Bool = false
    @StateObject var apiController = APIController()
    @Binding var example : Bool
    @Binding var movies : [Movie]
    @Binding var isLoading : Bool
    @Binding var Genre : [String]
    @Binding var streamingServices : [String]
    @Binding var isMovie : Bool
    @Binding var minYear : Int
    @Binding var maxYear : Int
    
    var body: some View {
        Button(
            action: {
                showingFilter.toggle()
            }, label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.system(size: 32))
                    .foregroundColor(.black)
            })
        
        .sheet(isPresented: $showingFilter){
            FilterView(minYear: $minYear, maxYear: $maxYear, example: $example, movies: $movies, Genre: $Genre, streamingServices: $streamingServices, isMovie: $isMovie, isLoading: $isLoading)
                
        }
    }
}


//struct TopBar_Previews: PreviewProvider {
//    @State static var e : Bool = false
//    static var previews: some View {
//        TopBar(example: $e)
//    }
//}
