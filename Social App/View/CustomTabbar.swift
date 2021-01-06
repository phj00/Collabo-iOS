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
                
                if title == "Projects" {
                    Image(systemName: "note.text")
                }
                if title == "Saved"{
                    Image(systemName: "rectangle.badge.checkmark")
                }
                if title == "Settings"{
                    Image(systemName: "gearshape")
                }
                //Image(title)
                //    .renderingMode(.template)
                
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
