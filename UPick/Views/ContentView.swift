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
    
    @StateObject var apiController = APIController()
    @State private var AboutShowing : Bool = false
    @State private var descriptionState : String = ""
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            TopBar()
       
            
            MovieScroll(AboutShowing: $AboutShowing, descriptionState: $descriptionState)
            
        }.frame(height: screenHeight)
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
