//
//  OutgoingApplicationRow.swift
//  Social App
//
//  Created by Ryan Koo on 2/17/21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct OutgoingApplicationRow: View {
    
    var application : ApplicationModel
    @ObservedObject var applicationData : ApplicationsViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 20) {
            
                Text("Position Applied: \(application.positionApplied)")
                    .font(.body)
                    .foregroundColor(.black)
                    
            }
            
            Divider()
            
            Text(application.applicationMessage)
                .font(.caption)
                .foregroundColor(.black)
                
        }
        .padding()
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
        )
        
    }
}
