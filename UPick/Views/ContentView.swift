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
    @State private var MovieState : Movie = Movie(title: "", img: "", description: "", StreamingServices: [""], genres: [""], year: "2017", rating: 00)
    @State private var showingFilter : Bool = false
    @State var movies : [Movie] = []
    @State var example : Bool = false
    @State var isLoading : Bool = false
    @State var Genre : [String] = [""]
    @State var StreamingServices : [String] = []
    @State var isMovie : Bool = true
    @State var minYear : Int = 1980
    @State var maxYear : Int = 2023
    @State var bookmarkedMovies : [Movie] = []
    @State var BookmarkedAboutShowing : Bool = false
    
    
    @State var isBookmarkView : Bool = false
    
    @StateObject var storageController = LocalStorage()
    
    var body: some View {
        VStack(spacing: 0) {
            
            if !isBookmarkView {
                
                TopBar(example: $example, movies: $movies, isLoading: $isLoading, Genre: $Genre, streamingServices: $StreamingServices, minYear: $minYear, maxYear: $maxYear, isMovie: $isMovie, isBookmarkView: $isBookmarkView)
                
                
                MovieScroll(AboutShowing: $AboutShowing, streamingServices: $StreamingServices, movies: $movies, isLoading: $isLoading, MovieState: $MovieState, bookmarkedMovies: $bookmarkedMovies, alreadyBookmarked: false)
                
            }
            
            
            else if isBookmarkView {
                BookmarkView(isBookmarkView: $isBookmarkView, bookmarkedMovies: $bookmarkedMovies, AboutShowing: $AboutShowing, BookmarkedAboutShowing: $BookmarkedAboutShowing, streamingServices: $StreamingServices, movies: $movies, isLoading: $isLoading, MovieState: $MovieState)
            }
            
        }.frame(height: screenHeight)
        
            .onAppear{
                storageController.getMovies(key: "bookmarked"){error in
                    if let error = error {
                        print("error getting the movies in contentView")
                    }
                    
                    else{
                        print("published var Movies after onAppear in contentView\(storageController.movies)")
                        
                        bookmarkedMovies = storageController.movies
                    }
                }
            }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
