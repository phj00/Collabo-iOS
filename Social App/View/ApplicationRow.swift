//
//  ApplicationRow.swift
//  Social App
//
//  Created by Ryan Koo on 2/17/21.
//

import SwiftUI
import Firebase

struct ApplicationRow: View {
    
    var application : ApplicationModel
    @ObservedObject var applicationData : ApplicationsViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 10){
                
                Text(application.applicantID)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
        
    }
}
