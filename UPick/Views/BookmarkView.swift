//
//  BookmarkView.swift
//  UPick
//
//  Created by johnny basgallop on 08/11/2023.
//

import SwiftUI
import WrappingHStack

struct BookmarkView: View {
    @Binding var isBookmarkView : Bool
    @StateObject var storageController = LocalStorage()
    @Binding var bookmarkedMovies : [Movie]
    @Binding var AboutShowing : Bool
    @Binding var streamingServices : [String]
    @Binding var movies : [Movie]
    @State var rerender : Bool = false
    @Binding var isLoading : Bool
    @Binding var MovieState : Movie
    
    var body: some View {
        
        @State var numberOfRows : Int = bookmarkedMovies.count
        @State var numberOfColumns : Int = 2
        
        VStack{
            
            HStack{
                
                Text("Bookmarked").font(.title).fontWeight(.bold).offset(y:12)
                
                Spacer()
                Button(action: {
                    isBookmarkView = false
                } , label: {
                    Text("back").foregroundColor(.blue)
                }).offset(y:12)
                
                
            }.padding(.horizontal, 30)
                .frame(height: screenHeight * 0.14)
            
            
            ScrollView(showsIndicators: false ) {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(0..<numberOfRows, id: \.self) { row in
                        HStack(spacing: 50) {
                            ForEach(0..<numberOfColumns, id: \.self) { column in
                                let index = row * numberOfColumns + column
                                if index < bookmarkedMovies.count {
                                    BookmarkedMovieImageButton(Img: bookmarkedMovies[index].img)
                                }
                            }
                        }
                    }
                    .padding(10)
                }
                
                
            }
            
            
            
            
        }
    }
}
    
    struct BookmarkedMovieImageButton: View {
        var Img : String
        var body: some View {
            
            VStack{
                Button(action: {
                    
                }, label: {
                    AsyncImage(url: URL(string: Img)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(7)
                            .frame(width: screenWidth / 3)
                        
                        
                    } placeholder: {
                        VStack{
                            ProgressView()
                        }.frame(width: screenWidth / 3, height: screenWidth * 0.5)
                    }
                })
         
            }
            
            .frame(width: screenWidth / 3)
        }
    }



struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView(isBookmarkView: .constant(true), bookmarkedMovies: .constant([Movie(title: "", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "", StreamingServices: [""], genres: [""], year: "", rating: 9.2), Movie(title: "", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "", StreamingServices: [""], genres: [""], year: "", rating: 9.2)]), AboutShowing: .constant(false), streamingServices: .constant(["netflix"]), movies: .constant([Movie(title: "", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "", StreamingServices: [""], genres: [""], year: "", rating: 9.2)]), isLoading: .constant(false), MovieState: .constant(Movie(title: "", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "", StreamingServices: [""], genres: [""], year: "", rating: 9.2)))
    }
}

