//
//  MovieInfoView.swift
//  UPick
//
//  Created by johnny basgallop on 10/10/2023.
//

import SwiftUI

struct MovieInfoView: View {
    
    @Binding var description : String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            MovieBrowseView(description: $description)
                .navigationBarTitle(Text("About"), displayMode: .large)
                .navigationBarItems(trailing: Button(action: {
                    dismiss()
                }) {
                    Text("Close").bold()
                })
            
            
        }.onAppear{
            print("as it appears, here is the movie desc: \(description)")
        }
    }
        
}


struct MovieBrowseView : View {
    
    @Binding var description : String
    
    var body: some View {
        VStack{
            Text(description)
                .padding(20)
                .offset(y: 20)
            
            Spacer()
        }
    }
}


struct MovieInfoView_Previews: PreviewProvider {
    @State static var D : String = "After an unexpected break up, a travel executive accepts an assignment to go undercover and learn about the tourist industry in Vietnam. Along the way, she finds adventure and romance with her Vietnamese expat tour guide and they decide to hijack the tour bus in order to explore life and love off the beaten path"
    static var previews: some View {
        MovieInfoView(description: $D)
    }
}
