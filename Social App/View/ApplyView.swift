//
//  ApplyView.swift
//  Social App
//
//  Created by Ryan Koo on 4/18/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ApplyView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var postId: String
    @State var position: String
    @StateObject var applyData : ApplyViewModel
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Button(action: {
                    applyData.currentView.toggle();
                    applyData.setPostId(postId: "");
                    applyData.setPostPosition(title: ""); applyData.setApplicationMessage(message: "")
                }) {
                    Image(systemName: "arrow.left.circle")
                        .font(.title)
                        .foregroundColor(Color("blue"))
                }
                
                Text("Apply")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
            }
            .padding()
            //.padding(.top,edges!.top)
            // Top Shadow Effect...
            .background(Color("bg"))
            //.shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
            

            Text("     Position Details:")
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("     \(position)")
                .italic()
                .foregroundColor(.white)
            
            Text("     @<Insert Company Name>")
                .foregroundColor(.white)
            
            Divider()
            
            Text("      Add a short message for your application:")
                .foregroundColor(.white)
            
            TextEditor(text: $applyData.applicationMessage)
                .cornerRadius(15)
                .background(Color(.clear))
                .padding()
//                .opacity(newPostData.isPosting ? 0.5 : 1)
//                .disabled(newPostData.isPosting ? true : false)
            
            Button(action: {
                applyData.applyTo(postId: postId); applyData.setPostPosition(title: ""); applyData.setPostId(postId: ""); applyData.currentView.toggle()
            }) {
                Text("Apply")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("blue"))
                    .clipShape(Capsule())
                    .padding()
                    .padding(.top,10)
                    
                
                Spacer(minLength: 0)
            }
            
            
        }
        
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        
    }
}
