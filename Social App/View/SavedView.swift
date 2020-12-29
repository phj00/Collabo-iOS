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
    
    var count = Int()
    
    var body: some View {
        
        VStack{
            HStack{
                Text("Saved Projects")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
                
            }
            .padding()
            .padding(.top,edges!.top)
            // Top Shadow Effect...
            .background(Color("bg"))
            .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
            
            
                    
            ScrollView{
                
                VStack(spacing: 15){
                    
                    ForEach(postData.Projects){post in
                        
                        if postData.savedContains(id: post.id){
                            PostRow(post: post, postData: postData)
                        }
                    }
                }
                .padding()
                .padding(.bottom,55)
            }
                
            
            
            Spacer(minLength: 0)
        }
    }
}
