import SwiftUI

struct JobCard: View {
    let job: Job

    private var gradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(hue: job.hue, saturation: 0.55, brightness: 0.50),
                Color(hue: job.hue, saturation: 0.70, brightness: 0.22),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(job.company.uppercased())
                        .font(.caption.weight(.bold))
                        .tracking(1.5)
                        .foregroundStyle(.white.opacity(0.7))
                    Text(job.title)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .lineLimit(3)
                        .minimumScaleFactor(0.8)
                }
                Spacer(minLength: 8)
                ScoreRing(score: job.score)
                    .frame(width: 64, height: 64)
            }

            HStack(spacing: 8) {
                Chip(icon: "mappin.and.ellipse", text: job.location)
                Chip(icon: "banknote", text: job.salary)
            }

            Text(job.summary)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(job.why, id: \.self) { line in
                    row(line, icon: "checkmark.circle.fill", tint: Theme.teal)
                }
                ForEach(job.gaps, id: \.self) { line in
                    row(line, icon: "exclamationmark.circle.fill", tint: Theme.amber)
                }
            }

            Spacer(minLength: 0)

            FlowLayout(spacing: 8) {
                ForEach(job.tags, id: \.self) { TagPill(text: $0) }
            }
        }
        .padding(22)
        .frame(maxWidth: .infinity, minHeight: 500, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous).fill(gradient)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .strokeBorder(.white.opacity(0.14), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.4), radius: 24, y: 14)
    }

    private func row(_ text: String, icon: String, tint: Color) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: icon).foregroundStyle(tint)
            Text(text)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
