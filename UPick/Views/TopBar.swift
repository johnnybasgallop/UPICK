//
//  TopBar.swift
//  UPick
//
//  Created by johnny basgallop on 24/09/2023.
//

import SwiftUI

struct TopBar : View {
    @Binding var example : Bool
    @Binding var movies : [Movie]
    @Binding var isLoading : Bool
    @Binding var Genre : [String]
    @Binding var streamingServices : [String]
    @Binding var minYear : Int
    @Binding var maxYear : Int
    @Binding var isMovie : Bool
    @Binding var isBookmarkView : Bool

    @State var logoutAlertShowing : Bool = false
    
    var body: some View {
        
        HStack {
            
            LogoutButton(logoutAlertShowing: $logoutAlertShowing)
            
            Spacer()
            
            Text("UPick")
                .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 25)).offset(x: screenWidth * 0.03)
            
            
            Spacer()
            HStack{
                FilterButton(example: $example, movies: $movies, isLoading: $isLoading, Genre: $Genre ,streamingServices: $streamingServices, isMovie: $isMovie, minYear: $minYear, maxYear: $maxYear).offset(x: -screenWidth * 0.04)
                
                BookMarkBtn(isBookmarkView: $isBookmarkView)
            }
        }
        .padding(.horizontal, 30)
        .frame(width: screenWidth ,height: screenHeight * 0.07)
        
        
        
        
    }
}


struct FilterButton : View {
    @State private var showingFilter : Bool = false
    @StateObject var apiController = APIController()
    @Binding var example : Bool
    @Binding var movies : [Movie]
    @Binding var isLoading : Bool
    @Binding var Genre : [String]
    @Binding var streamingServices : [String]
    @Binding var isMovie : Bool
    @Binding var minYear : Int
    @Binding var maxYear : Int
    
    var body: some View {
        Button(
            action: {
                showingFilter.toggle()
            }, label: {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
            })
        
        .sheet(isPresented: $showingFilter){
            FilterView(minYear: $minYear, maxYear: $maxYear, example: $example, movies: $movies, Genre: $Genre, streamingServices: $streamingServices, isMovie: $isMovie, isLoading: $isLoading)
                
        }
    }
}

struct BookMarkBtn : View {
    
    @Binding var isBookmarkView : Bool
    
    var body: some View {
        Button(
            action: {
                isBookmarkView = true
            }, label: {
                Image(systemName: "bookmark.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
            })
    }
}


struct LogoutButton : View {
    @Binding var logoutAlertShowing: Bool
    @AppStorage ("log_state") var log_state = false
    var body: some View {
        Button(
            action: {
                logoutAlertShowing = true
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 25))
                    .foregroundColor(.black)
            })
        
        .alert(isPresented: $logoutAlertShowing) {
                   Alert(
                    title: Text("Logout of account"),
                    message: Text("By confirming you will logout of your Upick account"),
                       primaryButton: .default(Text("Logout")) {
                           
                           log_state = false
                           
                          logoutAlertShowing = false
                       },
                       secondaryButton: .cancel(Text("Cancel")) {
                           logoutAlertShowing = false
                       }
                   )
               }
    }
}


struct TopBar_Previews: PreviewProvider {
    @State static var e : Bool = false
    static var previews: some View {
        TopBar(example: .constant(false), movies: .constant([Movie(title: "", img: "", description: "", StreamingServices: [""], genres: [""], year: "1970", rating: 3.5)]), isLoading: .constant(false), Genre: .constant([""]), streamingServices: .constant([""]), minYear: .constant(1930), maxYear: .constant(2000), isMovie: .constant(false), isBookmarkView: .constant(false))
    }
}
