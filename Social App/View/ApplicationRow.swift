//
//  ApplicationRow.swift
//  Social App
//
//  Created by Ryan Koo on 2/17/21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ApplicationRow: View {
    
    var application : ApplicationModel
    @ObservedObject var applicationData : ApplicationsViewModel
    let uid = Auth.auth().currentUser!.uid
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 20) {
            
                Text("Applicant: \(application.applicantUserName)")
                    .font(.body)
                
                WebImage(url: URL(string: application.applicantPhoto)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
            }
            
            Divider()
            
            Text(application.applicationMessage)
                .font(.caption)
                
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
        
    }
}
