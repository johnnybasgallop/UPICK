//
//  ScrollView.swift
//  UPick
//
//  Created by johnny basgallop on 23/09/2023.
//

import SwiftUI
import Snappable

struct MovieScroll: View {
    
    @StateObject var apiController = APIController()
    @Binding var AboutShowing : Bool
    @Binding var descriptionState : String
    @Binding var movies : [Movie]
    @State var rerender : Bool = false
   
    var body: some View{
        VStack(spacing:0){
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0){
                    ForEach(movies, id:  \.self) { movie in
                        VStack{
                            MovieCardView(AboutShowing: $AboutShowing, descriptionState: $descriptionState, title: movie.title, Img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500/\(movie.img)", description: movie.description, StreamingServices: movie.StreamingServices)
                        }.frame(width: screenWidth,height: screenHeight * 0.81)
                        
                    }
                    
                }
            }
            .frame(height: screenHeight * 0.81)
            .scrollTargetBehavior(.paging)
          
            .onAppear{
                
                print("MovieScroll has appeared")
                
                apiController.getData(FilterState : Filter(genres: ["27"], services: ["netflix"], minYear: 1980, maxYear: 2005, isMovie: true)) { error in
                    if let error = error {
                        // Handle the error
                        print("Error: \(error)")
                    } else {
                        
                        self.movies = apiController.Movies
                        
                        print("Data retrieval and processing completed")

                        
                    }
                }
            }
        }
    }
}


//struct MovieScroll_Previews: PreviewProvider {
//    @State static var AboutShowingPR : Bool = false
//    @State static var descriptionStatePr : String = "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas."
//    
//    static var previews: some View {
//        MovieScroll(AboutShowing: $AboutShowingPR, descriptionState: $descriptionStatePr)
//    }
//}
