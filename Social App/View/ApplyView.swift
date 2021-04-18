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
    @StateObject var applyData : ApplyViewModel
    
    var body: some View {
        
        VStack{
            
            Text(postId)
            
        }
        
        
    }
}
