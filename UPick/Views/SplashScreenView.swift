//
//  SplashScreenView.swift
//  UPick
//
//  Created by johnny basgallop on 17/10/2023.
//

import SwiftUI


struct SplashScreenView: View {
    @State private var isActive = false
    @State var title : String = "UPick."
    @State var animateTitle : String = ""
    @State var indexValue : Int = 0
    @State var timeInterval : TimeInterval = 0.2
    
    var body: some View {
        
        if isActive{
            ContentView()
        }
        
        else {
            
            Text(animateTitle).font(Font.custom("JetBrainsMonoRoman-ExtraBold", size: 50))
                .onAppear{
                    startAnimation()
                    withAnimation{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                            self.isActive = true
                        }
                    }
                }
        }
        
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true){ timer in
            
            if indexValue < title.count {
                animateTitle += String(title[title.index(title.startIndex, offsetBy: indexValue)])
                
                indexValue += 1
            }
            
            else{
                timer.invalidate()
            }
            
        }
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}


