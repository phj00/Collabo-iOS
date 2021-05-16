//
//  IncomingApplicationRow.swift
//  Social App
//
//  Created by Ryan Koo on 2/17/21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct IncomingApplicationRow: View {
    
    var application : ApplicationModel
    @ObservedObject var applicationData : ApplicationsViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 20) {
            
                Text("Applicant: \(application.applicantUserName)")
                    .font(.body)
                    .foregroundColor(.black)
                
                WebImage(url: URL(string: application.applicantPhoto)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
            }
            
            Divider()
            
            Text(application.applicationMessage)
                .font(.caption)
                .foregroundColor(.black)
                
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
        )
        
    }
}
