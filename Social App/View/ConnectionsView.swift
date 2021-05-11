import SwiftUI

struct ConnectionsView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var connectionData : ConnectionsViewModel
    @StateObject var profileData : ProfileViewModel
    @StateObject var applyData : ApplyViewModel
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                HStack {
                    Button(action: {
                        connectionData.temp.toggle();
                    }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.title)
                            .foregroundColor(Color("blue"))
                    }
                    
                    Text("Connections")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                }
                .padding()
                .padding(.top,edges!.top)
                .background(Color("bg"))
                .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
            }
            
            if connectionData.currentConnections.isEmpty {
                
                Spacer(minLength: 0)
                
                HStack {
                
                Text("No Connections")
                
                }
                
                Spacer(minLength: 0)
            }
            else {
                
                ScrollView {
                    
                    VStack (spacing: 15) {
                        
                        ForEach(connectionData.currentConnections){connection in
                            
                            ConnectionsRow(connection: connection, connectionData: connectionData, profileData: profileData, applyData: applyData)

                        }
                    }
                    
                }
            }
        }
    }
}
