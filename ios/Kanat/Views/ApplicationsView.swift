import SwiftUI

struct ApplicationsView: View {
    @Environment(Store.self) private var store
    @State private var selected: ApplicationStatus = .draft

    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        stats
                        pills
                        list
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
            }
            .navigationTitle("Başvurular")
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .sensoryFeedback(.selection, trigger: selected)
    }

    private var stats: some View {
        HStack(spacing: 12) {
            stat(value: store.applications.count, label: "Toplam", tint: Theme.sky)
            stat(value: store.count(for: .sent), label: "Gönderildi", tint: Theme.amber)
            stat(value: store.count(for: .interview), label: "Mülakat", tint: Theme.teal)
        }
    }

    private func stat(value: Int, label: String, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(value)")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(tint)
                .contentTransition(.numericText())
            Text(label)
                .font(.caption)
                .foregroundStyle(Theme.muted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Theme.surface))
    }

    private var pills: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ApplicationStatus.allCases) { status in
                    let isOn = status == selected
                    Button {
                        withAnimation(.snappy) { selected = status }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: status.icon).font(.caption)
                            Text(status.title).font(.subheadline.weight(.semibold))
                            Text("\(store.count(for: status))")
                                .font(.caption.weight(.bold))
                                .padding(.horizontal, 6)
                                .background(Capsule().fill(.white.opacity(0.18)))
                        }
                        .foregroundStyle(isOn ? .white : Theme.muted)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(isOn ? status.color : Theme.surface))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    @ViewBuilder
    private var list: some View {
        let items = store.applications.filter { $0.status == selected }
        if items.isEmpty {
            VStack(spacing: 10) {
                Image(systemName: selected.icon)
                    .font(.system(size: 36))
                    .foregroundStyle(selected.color.opacity(0.8))
                Text("Burada henüz bir şey yok")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else {
            VStack(spacing: 12) {
                ForEach(items) { row($0) }
            }
        }
    }

    private func row(_ app: Application) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle().fill(Color(hue: app.job.hue, saturation: 0.6, brightness: 0.6))
                Text(String(app.job.company.prefix(1)))
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 46, height: 46)

            VStack(alignment: .leading, spacing: 3) {
                Text(app.job.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                Text(app.job.company)
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
                Text(app.updated, style: .relative)
                    .font(.caption)
                    .foregroundStyle(Theme.muted.opacity(0.8))
            }
            Spacer(minLength: 8)

            Menu {
                ForEach(ApplicationStatus.allCases) { status in
                    Button {
                        withAnimation(.snappy) { store.move(app, to: status) }
                    } label: {
                        Label(status.title, systemImage: status.icon)
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.title3)
                    .foregroundStyle(Theme.muted)
            }
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 22, style: .continuous).fill(Theme.surface))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(.white.opacity(0.06), lineWidth: 1)
        )
    }
}
