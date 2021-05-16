//
//  SavedView.swift
//  Social App
//
//  Created by Ryan Koo on 12/28/20.
//

import SwiftUI

struct SavedView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var postData = PostViewModel()
    @StateObject var profileData = ProfileViewModel()
    @StateObject var applyData = ApplyViewModel()
    
    var body: some View {
        
        Color.white
            .ignoresSafeArea()
            .overlay(
            
                VStack{
                    HStack{
                        Text("Saved Posts")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.black)
                        
                        Spacer(minLength: 0)
                        
                    }
                    .padding()
                    .padding(.top,edges!.top)
                    // Top Shadow Effect...
//                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 0, y: 5)
                    
                    Divider()
                    
                    if !postData.getSaved().isEmpty {
                        ScrollView{
                            
                            VStack(spacing: 15){
                                
                                ForEach(postData.Postings){post in
                                    
                                    if postData.savedContains(id: post.id){
                                        PostRow(post: post, postData: postData, profileData: profileData, applyData: applyData)
                                    }
                                }
                            }
                            .padding()
                            .padding(.bottom,55)
                        }
                    } else {
                        Spacer(minLength: 0)
                        
                        Text("No Posts to View")

                        Spacer(minLength: 0)
                    }
                })
        
    }
}
