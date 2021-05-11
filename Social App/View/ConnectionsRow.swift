import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ConnectionsRow : View {
    
    var connection : ConnectionsModel
    @ObservedObject var connectionData : ConnectionsViewModel
    @ObservedObject var profileData : ProfileViewModel
    @ObservedObject var applyData : ApplyViewModel
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 20) {
                
                Button(action: {connectionData.setUser(userString: connection.id);
                        connectionData.temp.toggle();
//                        profileData.currentView.toggle()
                    
                },
                       label: {
                    Text(connection.username)
                        .font(.body)
                })
                
                WebImage(url: URL(string: connection.pic)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
            }
        }
//        .fullScreenCover(isPresented: $profileData.currentView) {
//            
//            ProfileView(profileData: profileData, connectionData: connectionData, applyData: applyData, userString : profileData.tempUserString)
//            
//        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
    }
}
