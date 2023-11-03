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
                
            
            
            
            
            Text(MovieState.description)
                .padding(.horizontal, 30)
                .padding(.vertical, 4)
                .font(.system(size: 20, weight: .medium))
            
            
            
            
            Spacer()
            
            
                .offset(y: 40)
            
        }
        .frame(width: screenWidth)
    }
}
    
    
    struct MovieInfo : View {
        @Binding var MovieState : Movie
        var body: some View {
            VStack(alignment: .leading){
                
                Text("\(MovieState.title)").font(.system(size: 27, weight: .semibold))
                    .padding(.vertical, 5)
                
                Text("(\(MovieState.year))").foregroundColor(.gray).offset(y: 5)

                HStack{
                    ForEach(MovieState.genres, id: \.self){ genre in
                        Text(genre.description)
                            .foregroundColor(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.black, lineWidth: 2) // Add rounded border
                            ).padding(.trailing, 4)
                    }
                }
                .padding(.top, 20)
                
            }.padding(30)
                .frame(width: screenWidth, alignment: .leading)
            
            
        }
    }
    
    
    
    struct MovieInfoView_Previews: PreviewProvider {
        @State static var movieState : Movie = Movie(title: "Example Movie", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas.", StreamingServices: ["disney", "prime"], genres: ["comedy", "drama"], year: "2017")
        static var previews: some View {
            MovieInfoView(MovieState: $movieState)
        }
    }

