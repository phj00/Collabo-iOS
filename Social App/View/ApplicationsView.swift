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
        
        ScrollView{
        
            VStack {
                
                HStack {
                
                    Text("Applications")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {applicationData.getAllIncomingApplications()}) {
                        
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title)
                            .foregroundColor(Color("blue"))
                        
                    }
                
                }
                .padding()
                .padding(.top,edges!.top)
                .background(Color("bg"))
                .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
                
            }
            
            if applicationData.IncomingApplications.isEmpty{
                
                Spacer(minLength: 0)
                
                HStack {
                
                Text("No Incoming Applications")
                
                }
                
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
}