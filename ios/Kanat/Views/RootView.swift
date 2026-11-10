import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem { Label("Keşfet", systemImage: "sparkles.rectangle.stack") }
            ApplicationsView()
                .tabItem { Label("Başvurular", systemImage: "paperplane") }
            InterviewView()
                .tabItem { Label("Mülakat", systemImage: "text.bubble") }
            ProfileView()
                .tabItem { Label("Profil", systemImage: "person.crop.circle") }
        }
        .tint(Theme.teal)
    }
}

#Preview {
    RootView().environment(Store()).preferredColorScheme(.dark)
}
