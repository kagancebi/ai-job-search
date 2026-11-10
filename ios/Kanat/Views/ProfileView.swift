import SwiftUI

struct ProfileView: View {
    @Environment(Store.self) private var store

    var body: some View {
        let profile = store.profile
        ZStack {
            Background()
            ScrollView {
                VStack(alignment: .leading, spacing: 26) {
                    header(profile)
                    section("Beceriler") {
                        FlowLayout(spacing: 8) {
                            ForEach(profile.skills, id: \.self) { TagPill(text: $0, tint: Theme.teal) }
                        }
                    }
                    section("Hedef sektörler") {
                        FlowLayout(spacing: 8) {
                            ForEach(profile.sectors, id: \.self) { TagPill(text: $0, tint: Theme.sky) }
                        }
                    }
                    section("Kesin hayır") {
                        FlowLayout(spacing: 8) {
                            ForEach(profile.dealbreakers, id: \.self) { TagPill(text: $0, tint: Theme.coral) }
                        }
                    }
                }
                .padding(20)
            }
        }
    }

    private func header(_ profile: Profile) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle().fill(LinearGradient(colors: [Theme.teal, Theme.sky], startPoint: .topLeading, endPoint: .bottomTrailing))
                Text(profile.initials)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }
            .frame(width: 72, height: 72)

            VStack(alignment: .leading, spacing: 4) {
                Text(profile.name)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text(profile.headline)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                Label(profile.location, systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundStyle(Theme.muted)
            }
        }
        .padding(.top, 8)
    }

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionTitle(text: title)
            content()
        }
    }
}
