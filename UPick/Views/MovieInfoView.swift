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
        NavigationView{
            MovieBrowseView(MovieState: $MovieState)
                .navigationBarTitle(Text("About"), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    dismiss()
                }) {
                    Text("Close").bold()
                })
            
            
        }
    }
    
}


struct MovieBrowseView : View {
    
    @Binding var MovieState : Movie
    
    var body: some View {
        VStack{
            
            HStack{
                AsyncImage(url: URL(string: MovieState.img)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(width: 120)
                        .padding()
                        .offset(x: 10)
                    
                    
                } placeholder: {
                    Color.gray
                }
                
                Spacer()
                
                MovieInfo(MovieState: $MovieState)
                    .padding(20)
            }
            
            Text(MovieState.description)
                .padding(20)
                .font(.system(size: 20, weight: .medium))
            
            
            
            
            Spacer()
        }
        
        .offset(y: 40)
        
    }
}


struct MovieInfo : View {
    @Binding var MovieState : Movie
    var body: some View {
        VStack{
            Text(MovieState.title).font(.system(size: 27, weight: .semibold))
            AvailableStreamingServicesGroup(StreamingServices: MovieState.StreamingServices).padding()
            
        }.frame(width: 200)
        
        
    }
}



struct MovieInfoView_Previews: PreviewProvider {
    @State static var movieState : Movie = Movie(title: "Example Movie", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas.", StreamingServices: ["disney", "prime"])
    static var previews: some View {
        MovieInfoView(MovieState: $movieState)
    }
}
