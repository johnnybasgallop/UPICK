//
//  ContentView.swift
//  UPick
//
//  Created by johnny basgallop on 12/09/2023.
//

import SwiftUI


var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width

struct ContentView: View {
    
    @State private var AboutShowing : Bool = false
    @State private var MovieState : Movie = Movie(title: "", img: "", description: "", StreamingServices: [""], genres: [""], year: "2017")
    @State private var showingFilter : Bool = false
    @State var movies : [Movie] = []
    @State var example : Bool = false
    @State var isLoading : Bool = false
    @State var Genre : [String] = [""]
    @State var StreamingServices : [String] = []
    @State var isMovie : Bool = true
    @State var minYear : Int = 1980
    @State var maxYear : Int = 2023
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            TopBar(example: $example, movies: $movies, isLoading: $isLoading, Genre: $Genre, streamingServices: $StreamingServices, minYear: $minYear, maxYear: $maxYear, isMovie: $isMovie)
            
            
            MovieScroll(AboutShowing: $AboutShowing, movies: $movies, isLoading: $isLoading, MovieState: $MovieState)
            
        }.frame(height: screenHeight)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
