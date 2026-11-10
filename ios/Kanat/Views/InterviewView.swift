import SwiftUI

struct InterviewView: View {
    @Environment(Store.self) private var store
    @State private var category: QuestionCategory?
    @State private var index = 0

    private var cards: [InterviewCard] {
        store.interviewCards.filter { category == nil || $0.category == category }
    }

    var body: some View {
        ZStack {
            Background()
            VStack(alignment: .leading, spacing: 16) {
                Text("Mülakat")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)

                filters

                if cards.isEmpty {
                    Spacer()
                } else {
                    TabView(selection: $index) {
                        ForEach(Array(cards.enumerated()), id: \.element.id) { i, card in
                            FlashCard(card: card)
                                .tag(i)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    progress
                }
            }
            .padding(.top, 8)
        }
        .onChange(of: category) { index = 0 }
    }

    private var filters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                filter(title: "Hepsi", tint: Theme.teal, isOn: category == nil) { category = nil }
                ForEach(QuestionCategory.allCases) { c in
                    filter(title: c.title, tint: c.color, isOn: category == c) { category = c }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    private func filter(title: String, tint: Color, isOn: Bool, action: @escaping () -> Void) -> some View {
        Button {
            withAnimation(.snappy, action)
        } label: {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isOn ? .white : Theme.muted)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(Capsule().fill(isOn ? tint : Theme.surface))
        }
        .buttonStyle(.plain)
    }

    private var progress: some View {
        VStack(spacing: 8) {
            ProgressView(value: Double(index + 1), total: Double(max(cards.count, 1)))
                .tint(Theme.teal)
            Text("\(index + 1) / \(cards.count) · çevirmek için karta dokun")
                .font(.caption)
                .foregroundStyle(Theme.muted)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 12)
    }
}

struct FlashCard: View {
    let card: InterviewCard
    @State private var flipped = false

    var body: some View {
        ZStack {
            face(label: card.category.title, text: card.question, tint: card.category.color, isAnswer: false)
                .opacity(flipped ? 0 : 1)
            face(label: "Cevap", text: card.answer, tint: Theme.teal, isAnswer: true)
                .opacity(flipped ? 1 : 0)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        }
        .rotation3DEffect(.degrees(flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0), perspective: 0.6)
        .onTapGesture {
            withAnimation(.spring(duration: 0.6)) { flipped.toggle() }
        }
        .sensoryFeedback(.selection, trigger: flipped)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
    }

    private func face(label: String, text: String, tint: Color, isAnswer: Bool) -> some View {
        VStack(alignment: .leading, spacing: 18) {
            TagPill(text: label, tint: tint)
            Text(text)
                .font(.system(size: isAnswer ? 20 : 26, weight: isAnswer ? .medium : .bold, design: .rounded))
                .foregroundStyle(.white)
                .fixedSize(horizontal: false, vertical: true)
            Spacer(minLength: 0)
            if !isAnswer {
                Label("Cevap için dokun", systemImage: "hand.tap")
                    .font(.footnote)
                    .foregroundStyle(Theme.muted)
            }
        }
        .padding(26)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(LinearGradient(
                    colors: [tint.opacity(isAnswer ? 0.22 : 0.38), Theme.surface],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .strokeBorder(tint.opacity(0.35), lineWidth: 1)
        )
    }
}
