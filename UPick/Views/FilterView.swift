//
//  FilterView.swift
//  UPick
//
//  Created by johnny basgallop on 26/09/2023.
//

import SwiftUI


struct FilterView: View {
    @StateObject var apiController = APIController()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("filter View")
            
            Button(action: {
                dismiss()
            }
                   , label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            
            Spacer()
            
            Button {
                
                apiController.getData { error in
                    if let error = error {
                        // Handle the error
                        print("Error: \(error)")
                    } else {
                        // The data retrieval and processing are complete, but no movie data is returned here
                        print("Data retrieval and processing completed")
                        print(apiController.Movies)
                        dismiss()
                    }
                }
                
                
                
            } label: {
                Text("getData")
            }
            
            Button {
           
                
                
            } label: {
                Text("get images")
            }.padding(60)
            
            Spacer()
            
            Text("Current Genre: \(apiController.FilterState.genres[0])")
            
            
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
