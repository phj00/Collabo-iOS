import SwiftUI

struct Home: View {
    
    @State var selectedTab = "Projects"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            // Custom Tab Bar....
            
            ZStack{
                
                PostView()
                    .opacity(selectedTab == "Projects" ? 1 : 0)
                
                SavedView()
                    .opacity(selectedTab == "Saved" ? 1 : 0)
                
                SettingsView()
                    .opacity(selectedTab == "Settings" ? 1 : 0)
                
                ApplicationsView()
                    .opacity(selectedTab == "Applications" ? 1 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            CustomTabbar(selectedTab: $selectedTab)
                .padding(.bottom,edges!.bottom == 0 ? 15 : 0)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .top)
    }
}

