//
//  ContentView.swift
//  UPick
//
//  Created by johnny basgallop on 12/09/2023.
//

import SwiftUI


var screenHeight = UIScreen.main.bounds.height
var screenWidth = UIScreen.main.bounds.width

struct ContentView: View {
    
    @State private var AboutShowing : Bool = false
    @State private var descriptionState : String = ""
    @State private var showingFilter : Bool = false
    @State var movies : [Movie] = []
    @State var example : Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            TopBar(example: $example, movies: $movies)
       
            
            MovieScroll(AboutShowing: $AboutShowing, descriptionState: $descriptionState, movies: $movies)
            
        }.frame(height: screenHeight)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
