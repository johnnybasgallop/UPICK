//
//  MovieCardView.swift
//  UPick
//
//  Created by johnny basgallop on 12/09/2023.
//

import SwiftUI
import ContentBlurView
import SwiftUIGradientBlur


struct MovieCardView: View {
    
    @Binding var AboutShowing : Bool
    @Binding var MovieState : Movie
    @Binding var streamingServices : [String]
    @Binding var bookmarkedMovie : [Movie]
    
    var title : String
    var Img : String
    var description : String
    var StreamingServices : [String]
    var year : String
    var genres : [String]
    var rating : Double
    var alreadyBookmarked : Bool
    
    var body: some View {
        
        VStack{
            
            AsyncImage(url: URL(string: Img)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(7)
                    .overlay(
                        BookMarkButton( MovieState: $MovieState, bookmarkedMovies: $bookmarkedMovie, alreadyBookmarked: alreadyBookmarked, description: description, title: title, img: Img, streamingServices: streamingServices, year: year, genres: genres, rating: rating).offset(x: screenWidth * 0.35, y: screenHeight * 0.25)
                    )
                
            } placeholder: {
                ProgressView().frame(width: screenWidth * 0.9, height: screenHeight * 0.7)
            }
            .frame(width: screenWidth * 0.9)
            //                .offset(y: -20)
            
            Spacer()
            
            
            
            HStack{
                AvailableStreamingServicesGroup(StreamingServices: StreamingServices, isCard: true, streamingServices: $streamingServices)
                Spacer()
                MoreInfoButton(AboutShowing: $AboutShowing, MovieState: $MovieState, description: description, title: title, img: Img, streamingServices: StreamingServices, year: year, genres: genres, rating: rating )
            }
            
            
            
        }
        
        
        
        .frame(width: screenWidth * 0.9, height: screenHeight * 0.75 ,alignment: .center)
    }
}



struct MoreInfoButton : View {
    
    @Binding var AboutShowing : Bool
    @Binding var MovieState : Movie
    
    var description : String
    var title : String
    var img : String
    var streamingServices : [String]
    var year : String
    var genres : [String]
    var rating : Double
    
    
    
    var body: some View {
        Button(action: {
            
            AboutShowing.toggle()
            MovieState.description = description
            MovieState.img = img
            MovieState.title = title
            MovieState.StreamingServices = streamingServices
            MovieState.year = year
            MovieState.genres = genres
            MovieState.rating = rating
            
        }, label: {
            Text("More Info")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 30) // Add horizontal padding to create a pill shape
                .padding(.vertical, 15) // Add vertical padding for height
                .background(Capsule().fill(Color.black))
            
        })
        .sheet(isPresented: $AboutShowing){
            MovieInfoView(MovieState: $MovieState)
                .presentationDetents([.fraction(0.45), .large])
        }
        
    }
}


struct BookMarkButton : View {
    @State var isSelected : Bool = false
    @Binding var MovieState : Movie
    @StateObject var storageController = LocalStorage()
    @Binding var bookmarkedMovies : [Movie]
    var alreadyBookmarked : Bool
    
    var description : String
    var title : String
    var img : String
    var streamingServices : [String]
    var year : String
    var genres : [String]
    var rating : Double
    var body: some View {
        
        
        
        
        Button(action: {
            
          
            isSelected.toggle()
            
            if isSelected {
                
                storageController.AppendMovie(bookmarkedMovies: bookmarkedMovies, movie: Movie(title: title, img: img, description: description, StreamingServices: streamingServices, genres: genres, year: year, rating: rating), key: "bookmarked"){error in
                    if let error = error{
                        print("error calling the appendMovie function in the MoviecardView: L138-145")
                    }
                    
                    else{
                        withAnimation(Animation.easeInOut(duration: 0.5)){
                            bookmarkedMovies = storageController.movies
                        }
                      
                    }
                }
                
                
                
            }
            
            
        }, label: {
            ZStack{
                Circle().frame(width: 50).foregroundColor(.white)
                Image(systemName: isSelected || alreadyBookmarked ? "bookmark.fill" : "bookmark").font(.system(size: 24)).foregroundColor(.black)
            }
        })
    }
}

struct AvailableStreamingServicesGroup : View {
    
    var StreamingServices: [String]
    var isCard : Bool
    
    @Binding var streamingServices : [String]
    
    var body: some View{
        HStack(spacing: -6){
            
            
            
            let sorted = StreamingServices.sorted  { item1, item2 in
                if streamingServices.contains(item1) && !streamingServices.contains(item2) {
                    return false
                } else if streamingServices.contains(item2) && !streamingServices.contains(item1) {
                    return true
                } else {
                    return item1 < item2
                }
            }
            
            var newArr = Array(sorted.suffix(3))
            
            ForEach(isCard ? newArr : sorted , id: \.self) { string in
                
                StreamingServiceIndicator(text: string)
            }
            
        }
        .environment(\.layoutDirection, .rightToLeft)
        
    }
}


struct StreamingServiceIndicator : View {
    var text : String
    
    var body: some View{
        
        
        
        ZStack {
            
            switch text{
            case "netflix":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/netlfix.jpeg?alt=media&token=1f0f7a76-76fc-40b8-8bd8-c8e026850c11&_gl=1*3vtr0x*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzU0MTcuNTUuMC4w")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 48, height: 48)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(35)
                
            case "apple":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/atv.jpeg?alt=media&token=bc11d27b-c7e7-4021-a47b-020dfd607e47&_gl=1*5l3ay4*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzQ5OTQuOC4wLjA.")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                                            .background(.white)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(24)
              

                
            case "iplayer":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/bbcIplayer.png?alt=media&token=e00acdea-ac37-4543-945f-bd4fe9fda281&_gl=1*1xwygs6*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzUyNjguNTUuMC4w")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(24)
                
            case "prime":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/primevideo-removebg-preview.png?alt=media&token=375c6cfe-e6f7-474a-993a-aebd391ee566&_gl=1*tnfjl*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzUxNzMuNTMuMC4w")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(30)
                
            case "disney":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/disney.jpeg?alt=media&token=3c727285-eaf2-4e41-bc6b-4176b5126e47&_gl=1*50k677*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzYwOTkuNTMuMC4w")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(30)
                
            case "now":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/nowtv.png?alt=media&token=374042d7-d2a2-4244-b442-92b976b05829&_gl=1*of3jr9*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTE0MDg3MC4xNC4xLjE2OTkxNDA4NzguNTIuMC4w")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(25)
                
            case "paramount":
                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/cbstocks-79297.appspot.com/o/paramountplus.jpeg?alt=media&token=c39bd8f0-f1f5-4d53-ba6d-4118c241e2ec&_gl=1*7hkrz2*_ga*NTY5OTQ4NjIyLjE2OTIzNjI3ODA.*_ga_CW55HF8NVT*MTY5OTEzNDk0Mi4xMy4xLjE2OTkxMzYwMDMuNDEuMC4w")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 50, height: 50)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(24)
                
                
                
            default:
                Text("?")
                
                
                
            }
            
            
            
            
            // Adjust the offset as needed// Adjust the corner radius to your preference
        }
        
        .frame(width: 50, height: 50)
//        .overlay(
//            RoundedRectangle(cornerRadius: 45)
//                .stroke(Color(UIColor.gray), lineWidth: 0.8)
//        )
//        .background(.white)
        .offset(x: -15)
    }
}


struct MovieCardView_Previews: PreviewProvider {
    @State static var imgPR : String = "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg"
    
    @State static var title : String = "Christmas Time is Here"
    
    @State static var description : String = "This is an example descriotion for a rabndom movie and im not sure what that movie is going to be yet but this is just for UI preview purposes"
    
    @State static var AboutShowingPR : Bool = false
    
    @State static var descriptionState : String = "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas."
    
    @State static var streamingServices : [String] = ["netflix", "paramount", "now", "disney"]
    
    @State static var movieState : Movie = Movie(title: "", img: "", description: "", StreamingServices: [""], genres: [""], year: "", rating: 00)
    
    static var previews: some View {
        MovieCardView(AboutShowing: $AboutShowingPR, MovieState: $movieState, streamingServices: .constant(["now", "disney"]), bookmarkedMovie: .constant([Movie(title: "", img: "", description: "", StreamingServices: [""], genres: [""], year: "", rating: 8.1)]), title: title, Img: imgPR, description: description, StreamingServices: streamingServices, year: "2017", genres: [""], rating: 5.5, alreadyBookmarked: false)
    }
}
