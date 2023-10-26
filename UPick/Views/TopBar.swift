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
    var body: some View {
        
            HStack {
                Text("UPick.")
                    .font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 40))
 
                    
                Spacer()
                FilterButton(example: $example, movies: $movies)
            }
            .padding(.horizontal, 30) 
            .frame(height: screenHeight * 0.07)
                
        
        
    }
}


struct FilterButton : View {
    @State private var showingFilter : Bool = false
    @StateObject var apiController = APIController()
    @Binding var example : Bool
    @Binding var movies : [Movie]
    
    var body: some View {
        Button(
            action: {
                print("FilterBtn Pressed")
                showingFilter.toggle()
            }, label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.system(size: 32))
                    .foregroundColor(.black)
            })
    
        .sheet(isPresented: $showingFilter){
            FilterView(example: $example, movies: $movies)
        }
    }
}


//struct TopBar_Previews: PreviewProvider {
//    @State static var e : Bool = false
//    static var previews: some View {
//        TopBar(example: $e)
//    }
//}
