import SwiftUI

struct CustomTabbar: View {
    @Binding var selectedTab : String
    var body: some View {
        
        HStack(spacing: 53){
            
            TabButton(title: "Projects", selectedTab: $selectedTab)
            
            TabButton(title: "Saved", selectedTab: $selectedTab)
            
            TabButton(title: "Settings", selectedTab: $selectedTab)
        }
        .padding(.horizontal)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

struct TabButton : View {
    
    var title : String
    @Binding var selectedTab : String
    
    var body: some View{
        
        Button(action: {selectedTab = title}) {
            
            VStack(spacing: 5){
                
                Image(title)
                    .renderingMode(.template)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .foregroundColor(selectedTab == title ? Color("blue") : .gray)
            .padding(.horizontal)
            .padding(.vertical,10)
        }
    }
}
