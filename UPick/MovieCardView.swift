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
    @Binding var descriptionState : String
    
    
    var title : String
    var Img : String
    var description : String
    var StreamingServices : [String]
    
    
    
    var body: some View {
        
        VStack{
            
            AsyncImage(url: URL(string: Img)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(7)
                
                
            } placeholder: {
                Color.gray
            }
            .frame(width: screenWidth * 0.9)
            //                .offset(y: -20)
            
            Spacer()
            
           
            
            HStack{
                AvailableStreamingServicesGroup(StreamingServices: StreamingServices)
                Spacer()
                MoreInfoButton(AboutShowing: $AboutShowing, description: description, title: title, descriptionState: $descriptionState)
            }
            
            
            
        }
        
        
        
        .frame(width: screenWidth * 0.9, height: screenHeight * 0.75 ,alignment: .center)
    }
}



struct MoreInfoButton : View {
    
    @Binding var AboutShowing : Bool
    
    var description : String
    var title : String
    
    
    @Binding var descriptionState : String
    
    var body: some View {
        Button(action: {
            
            print("more info pressed for movie: \(title)")
            AboutShowing.toggle()
            descriptionState = description
            print(descriptionState)
            
        }, label: {
            Text("More Info")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 30) // Add horizontal padding to create a pill shape
                .padding(.vertical, 15) // Add vertical padding for height
                .background(Capsule().fill(Color.black))
            
        })
        .sheet(isPresented: $AboutShowing){
            MovieInfoView(description: $descriptionState)
        }
        
    }
}

struct AvailableStreamingServicesGroup : View {
    
    var StreamingServices: [String]
    
    var body: some View{
        HStack(spacing: -12){
            
            ForEach(StreamingServices, id: \.self) { string in
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
                AsyncImage(url: URL(string: "https://logo.clearbit.com/Netflix.com")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(15)
                
            case "apple":
                AsyncImage(url: URL(string: "https://logo.clearbit.com/apple.com")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(18)
                
            case "prime":
                AsyncImage(url: URL(string: "https://logo.clearbit.com/primevideo.com")) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40)
                } placeholder: {
                    ProgressView()
                }
                .cornerRadius(30)
                
            case "disney":
                
                Image("DisneyIcon")
                    .resizable().aspectRatio(contentMode: .fit).frame(width: 70, height: 70)
                        .cornerRadius(30)
              
                
            default:
                Text("?")
                
            
                
            }
            
       
            
            
            // Adjust the offset as needed// Adjust the corner radius to your preference
        }
        
        .frame(width: 50, height: 50)
        .overlay(
            RoundedRectangle(cornerRadius: 45)
                .stroke(Color(UIColor.gray), lineWidth: 2)
        )
        .background(.white)
        .offset(x: -15)
    }
}


struct MovieCardView_Previews: PreviewProvider {
    @State static var imgPR : String = "https://image.tmdb.org/t/p/w500//https://image.tmdb.org/t/p/w500///ay1EBaNZa8Bkh8uvNhfJ9rY70pk.jpg"
    
    @State static var title : String = "Christmas Time is Here"
    
    @State static var description : String = "This is an example descriotion for a rabndom movie and im not sure what that movie is going to be yet but this is just for UI preview purposes"
    
    @State static var AboutShowingPR : Bool = false
    
    @State static var descriptionState : String = "With his carefree lifestyle on the line, a wealthy charmer poses as a ranch hand to get a hardworking farmer to sell her family’s land before Christmas."
    
    @State static var streamingServices : [String] = ["netflix", "apple", "prime", "disney"]
    
    static var previews: some View {
        MovieCardView(AboutShowing: $AboutShowingPR, descriptionState: $descriptionState, title: title, Img: imgPR, description: description, StreamingServices: streamingServices)
    }
}
