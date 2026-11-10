import SwiftUI

struct Job: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var company: String
    var location: String
    var salary: String
    var score: Int            // 0...100 fit score
    var summary: String
    var why: [String]         // why it fits
    var gaps: [String]        // honest gaps
    var tags: [String]
    var hue: Double           // card tint, 0...1
}

enum ApplicationStatus: String, CaseIterable, Identifiable {
    case draft, sent, interview, outcome

    var id: String { rawValue }

    var title: String {
        switch self {
        case .draft: "Taslak"
        case .sent: "Gönderildi"
        case .interview: "Mülakat"
        case .outcome: "Sonuç"
        }
    }

    var icon: String {
        switch self {
        case .draft: "pencil.line"
        case .sent: "paperplane.fill"
        case .interview: "person.2.fill"
        case .outcome: "flag.checkered"
        }
    }

    var color: Color {
        switch self {
        case .draft: Theme.sky
        case .sent: Theme.amber
        case .interview: Theme.teal
        case .outcome: Theme.coral
        }
    }
}

struct Application: Identifiable, Hashable {
    let id = UUID()
    var job: Job
    var status: ApplicationStatus
    var updated: Date
}

enum QuestionCategory: String, CaseIterable, Identifiable {
    case technical, behavioral, ask

    var id: String { rawValue }

    var title: String {
        switch self {
        case .technical: "Teknik"
        case .behavioral: "Davranışsal"
        case .ask: "Sen sor"
        }
    }

    var color: Color {
        switch self {
        case .technical: Theme.sky
        case .behavioral: Theme.amber
        case .ask: Theme.teal
        }
    }
}

struct InterviewCard: Identifiable, Hashable {
    let id = UUID()
    var category: QuestionCategory
    var question: String
    var answer: String
}

struct Profile {
    var name: String
    var headline: String
    var location: String
    var skills: [String]
    var sectors: [String]
    var dealbreakers: [String]

    var initials: String {
        name.split(separator: " ").prefix(2).compactMap { $0.first }.map(String.init).joined()
    }
}
