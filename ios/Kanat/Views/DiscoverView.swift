import SwiftUI

struct DiscoverView: View {
    @Environment(Store.self) private var store
    @State private var drag: CGSize = .zero

    private let threshold: CGFloat = 110

    var body: some View {
        ZStack {
            Background()
            VStack(spacing: 18) {
                header
                if store.deck.isEmpty {
                    emptyState
                } else {
                    deck
                    buttons
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: store.deck.count)
    }

    // MARK: Pieces

    private var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Keşfet")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text("\(store.deck.count) ilan seni bekliyor")
                    .font(.subheadline)
                    .foregroundStyle(Theme.muted)
            }
            Spacer()
        }
    }

    private var deck: some View {
        let visible = Array(store.deck.prefix(3))
        return ZStack {
            ForEach(Array(visible.enumerated()).reversed(), id: \.element.id) { index, job in
                if index == 0 {
                    JobCard(job: job)
                        .overlay(stamp)
                        .offset(drag)
                        .rotationEffect(.degrees(Double(drag.width / 18)), anchor: .bottom)
                        .gesture(dragGesture(for: job))
                        .zIndex(10)
                } else {
                    JobCard(job: job)
                        .scaleEffect(1 - 0.05 * CGFloat(index))
                        .offset(y: 16 * CGFloat(index))
                        .opacity(1 - 0.25 * Double(index))
                        .allowsHitTesting(false)
                        .zIndex(Double(10 - index))
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private var stamp: some View {
        let apply = drag.width > 0
        let strength = min(abs(drag.width) / threshold, 1)
        return Text(apply ? "BAŞVUR" : "GEÇ")
            .font(.system(size: 34, weight: .black, design: .rounded))
            .tracking(2)
            .foregroundStyle(apply ? Theme.teal : Theme.coral)
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(apply ? Theme.teal : Theme.coral, lineWidth: 4)
            )
            .rotationEffect(.degrees(apply ? -14 : 14))
            .opacity(strength)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: apply ? .topLeading : .topTrailing)
            .padding(28)
            .allowsHitTesting(false)
    }

    private var buttons: some View {
        HStack(spacing: 40) {
            circleButton(icon: "xmark", tint: Theme.coral) { fling(-1) }
            circleButton(icon: "checkmark", tint: Theme.teal) { fling(1) }
        }
        .padding(.bottom, 8)
    }

    private func circleButton(icon: String, tint: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title2.weight(.bold))
                .foregroundStyle(tint)
                .frame(width: 64, height: 64)
                .background(Circle().fill(tint.opacity(0.16)))
                .overlay(Circle().strokeBorder(tint.opacity(0.5), lineWidth: 1.5))
        }
        .buttonStyle(.plain)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "bird")
                .font(.system(size: 56))
                .foregroundStyle(Theme.teal)
            Text("Bugünlük bu kadar")
                .font(.title2.weight(.bold))
                .foregroundStyle(.white)
            Text("Yeni ilanlar geldiğinde burada görünecek.")
                .font(.subheadline)
                .foregroundStyle(Theme.muted)
            Button("Desteyi yenile") {
                withAnimation(.spring(duration: 0.5)) { store.resetDeck() }
            }
            .buttonStyle(.borderedProminent)
            .tint(Theme.teal)
            .padding(.top, 8)
            Spacer()
        }
    }

    // MARK: Gestures

    private func dragGesture(for job: Job) -> some Gesture {
        DragGesture()
            .onChanged { drag = $0.translation }
            .onEnded { value in
                if value.translation.width > threshold {
                    fling(1)
                } else if value.translation.width < -threshold {
                    fling(-1)
                } else {
                    withAnimation(.spring(duration: 0.4, bounce: 0.3)) { drag = .zero }
                }
            }
    }

    /// Throws the top card off screen, then commits the decision.
    private func fling(_ direction: CGFloat) {
        guard let top = store.deck.first else { return }
        withAnimation(.easeIn(duration: 0.25), completionCriteria: .logicallyComplete) {
            drag = CGSize(width: direction * 700, height: drag.height)
        } completion: {
            var instant = Transaction()
            instant.disablesAnimations = true
            withTransaction(instant) { drag = .zero }
            withAnimation(.spring(duration: 0.4)) {
                if direction > 0 { store.accept(top) } else { store.skip(top) }
            }
        }
    }
}
