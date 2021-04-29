import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ConnectionsRow : View {
    
    var follower : String
    @ObservedObject var connectionData : ConnectionsViewModel
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(spacing: 20) {
                
                Button(action: {connectionData.setUser(userString: follower); connectionData.setImage(userString: follower); connectionData.temp.toggle()}, label: {
                    Text(connectionData.tempString)
                        .font(.body)
                })
                
                WebImage(url: URL(string: connectionData.imageString)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    
            }
        }
        .padding()
        .background(Color.white.opacity(0.06))
        .cornerRadius(15)
    }
}
