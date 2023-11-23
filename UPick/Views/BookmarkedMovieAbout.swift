//
//  BookmarkedMovieAbout.swift
//  UPick
//
//  Created by johnny basgallop on 19/11/2023.
//

//
//  MovieInfoView.swift
//  UPick
//
//  Created by johnny basgallop on 10/10/2023.
//

import SwiftUI

struct BookmarkedMovieAbout: View {
    @Binding var MovieState : Movie
    @Binding var BookmarkedMoviesShowing : Bool
    @Binding var bookmarkedMovies : [Movie]
    @State var AlertShowing: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        BookmarkedBrowseView(MovieState: $MovieState, bookmarkedMovies: $bookmarkedMovies, AlertShowing: $AlertShowing)
        
            .onDisappear{
                BookmarkedMoviesShowing = false
            }
        
    }

    
}


struct BookmarkedBrowseView : View {
    
    @Binding var MovieState : Movie
    @Binding var bookmarkedMovies : [Movie]
    @Binding var AlertShowing: Bool
    
    var body: some View {
        ScrollView{
            VStack{
                
                AsyncImage(url: URL(string: MovieState.img)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(7)
                    
                    
                } placeholder: {
                    Color.gray
                }.overlay(
                    BookmarkRemoveBtn(MovieState: $MovieState, bookmarkedMovies: $bookmarkedMovies, AlertShowing: $AlertShowing).offset(x: screenWidth * 0.4, y: screenWidth * -0.6)
                )
                
                
                
                BookmarkedInfo(MovieState: $MovieState)
                
                
                
                
                
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
}
    
    
    struct BookmarkedInfo : View {
        @Binding var MovieState : Movie
        
        
        
        var body: some View {
            
            let movieRating = String(format: "%.1f", MovieState.rating)
            
            VStack(alignment: .leading){
                
                Text("\(MovieState.title)").font(.system(size: 27, weight: .semibold))
                    .padding(.vertical, 5)
                
                Text("\(movieRating)/10").foregroundColor(.yellow).font(.system(size: 20, weight: .bold))
                
                HStack{
                    
                    Text("(\(MovieState.year))").foregroundColor(.gray)
                    
                    AvailableStreamingServicesGroup(StreamingServices: MovieState.StreamingServices, isCard: false, streamingServices: .constant(["netflix"]))
                    
                }.offset(y: 5)

                HStack{
                    ForEach(MovieState.genres, id: \.self){ genre in
                        Text(genre.description)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(.black)
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
    
    

struct BookmarkRemoveBtn : View {
    @StateObject var storageController = LocalStorage()
    @Binding var MovieState : Movie
    @Binding var bookmarkedMovies : [Movie]
    @Environment(\.dismiss) var dismiss
    @Binding var AlertShowing: Bool
    
    var body: some View {
        Button(action: {
            AlertShowing = true
        }, label: {
            ZStack{
                Circle().frame(width: 50).foregroundColor(.white)
                Image(systemName: "bookmark.fill").font(.system(size: 24)).foregroundColor(.black)
            }

        })
        .alert(isPresented: $AlertShowing) {
                   Alert(
                    title: Text("UnBookmark \(MovieState.title)"),
                    message: Text("By confirming you will remove \(MovieState.title) from your bookmarked movies"),
                       primaryButton: .default(Text("Confirm")) {
                           storageController.deleteMovie(movieTitle: MovieState.title, key: "bookmarked"){error in
                               if let error = error {
                                   print(error)
                               }
                               else {
                                   bookmarkedMovies = storageController.movies
                                   dismiss()
                                   print("bookmarkedMovies: \(bookmarkedMovies)")
                               }
                           }
                           
                           AlertShowing = false
                       },
                       secondaryButton: .cancel(Text("Cancel")) {
                           AlertShowing = false
                       }
                   )
               }
    }
}


    
    struct BookmarkedMovieAbout_Previews: PreviewProvider {
        @State static var movieState : Movie = Movie(title: "Example Movie", img: "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg", description: "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas.", StreamingServices: ["disney", "prime"], genres: ["comedy", "drama"], year: "2017", rating: 8.3)
        static var previews: some View {
            BookmarkedMovieAbout(MovieState: $movieState, BookmarkedMoviesShowing: .constant(false), bookmarkedMovies: .constant([Movie(title: "", img: "", description: "", StreamingServices: [""], genres: [""], year: "", rating: 9.2)]))
        }
    }

