//
//  TopBar.swift
//  UPick
//
//  Created by johnny basgallop on 24/09/2023.
//

import SwiftUI

struct TopBar : View {
    var body: some View {
        
            HStack {
                Text("UPICK")
                    .font(.system(size: 45, weight: .bold))
                    
                Spacer()
                FilterButton()
            }
            .padding(.horizontal, 30) 
            .frame(height: screenHeight * 0.07)
                
        
        
    }
}


struct FilterButton : View {
    @State private var showingFilter : Bool = false
    
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
            FilterView()
        }
    }
}


struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
    }
}
