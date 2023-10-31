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
    
    @Binding var movies : [Movie]
    @State var rerender : Bool = false
    @Binding var isLoading : Bool
    @Binding var MovieState : Movie
    
    var body: some View{
        VStack(spacing:0){
            
            if movies.isEmpty && !isLoading {
                
                Text("Search for a movie...").foregroundColor(.gray)
                    .offset(y: 300)
                   
                
                
            }
            
            if isLoading {
                VStack{
                    ProgressView()
                }.frame(height: screenHeight * 0.81)
            }
            
            else {
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 0){
                        ForEach(movies, id:  \.self) { movie in
                            VStack{
                                MovieCardView(AboutShowing: $AboutShowing, MovieState: $MovieState, title: movie.title, Img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500/\(movie.img)", description: movie.description, StreamingServices: movie.StreamingServices)
                            }.frame(width: screenWidth,height: screenHeight * 0.81)
                            
                        }
                        
                    }
                }
                .frame(height: screenHeight * 0.81)
                .scrollTargetBehavior(.paging)
                
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
