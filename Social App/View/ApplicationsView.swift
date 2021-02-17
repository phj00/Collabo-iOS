//
//  ApplicationsView.swift
//  Social App
//
//  Created by Ryan Koo on 2/9/21.
//

import SwiftUI

struct ApplicationsView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var applicationData = ApplicationsViewModel()
    var body: some View {
        
        VStack {
            
            Text("Applications")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            
            Spacer(minLength: 0)
            
        }
        .padding()
        .padding(.top,edges!.top)
        .background(Color("bg"))
        .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
        
        if applicationData.IncomingApplications.isEmpty{
            
            Spacer(minLength: 0)
            
            Text("No Projects to View")
            
            Spacer(minLength: 0)
            
        } else {
            
            ScrollView{
                
                VStack(spacing: 15){
                    
                    ForEach(applicationData.IncomingApplications){application in
                        
                        ApplicationRow(application: application, applicationData: applicationData)
                        
                    }
                }
                .padding()
                .padding(.bottom,55)
            }
            
        }
        
    }
}
