//
//  MovieInfoView.swift
//  UPick
//
//  Created by johnny basgallop on 10/10/2023.
//

import SwiftUI

struct MovieInfoView: View {
    @Binding var MovieState : Movie
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            MovieBrowseView(MovieState: $MovieState)
    }
    
}


struct MovieBrowseView : View {
    
    @Binding var MovieState : Movie
    
    var body: some View {
        VStack{
            
            
            MovieInfo(MovieState: $MovieState)
                .padding(20)
            
            
            
            
            Text(MovieState.description)
                .padding(30)
                .font(.system(size: 20, weight: .medium))
            
            
            
            
            Spacer()
            
            
                .offset(y: 40)
            
        }
    }
}
    
    
    struct MovieInfo : View {
        @Binding var MovieState : Movie
        var body: some View {
            VStack{
                HStack{
                    Text("\(MovieState.title)  (\(MovieState.year))").font(.system(size: 27, weight: .semibold))
                        .padding(.leading, 30)
                        .padding(.trailing,5)
                        .padding(.vertical, 5)
                    
                    
                }
 
//                AvailableStreamingServicesGroup(StreamingServices: MovieState.StreamingServices).padding()
                
            }.frame(width: screenWidth * 0.95, alignment: .leading)
            
            
        }
    }
    
    
    
    struct MovieInfoView_Previews: PreviewProvider {
        @State static var movieState : Movie = Movie(title: "Example Movie", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas.", StreamingServices: ["disney", "prime"], year: "2017")
        static var previews: some View {
            MovieInfoView(MovieState: $movieState)
        }
    }

