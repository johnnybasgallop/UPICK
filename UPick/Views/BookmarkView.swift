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
        
        VStack{
            
            HStack{
                Button(action: {
                    isBookmarkView = false
                } , label: {
                    Text("back").foregroundColor(.blue)
                }).padding()
                
                Spacer()
            }
        
          
        
    }
        
        
        
            
    }
}

