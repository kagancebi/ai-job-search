import SwiftUI

@Observable
final class Store {
    var deck: [Job] = SampleData.jobs
    var applications: [Application] = SampleData.applications
    var interviewCards: [InterviewCard] = SampleData.interviewCards
    var profile: Profile = SampleData.profile

    /// Swipe right: the job becomes a draft application.
    func accept(_ job: Job) {
        deck.removeAll { $0.id == job.id }
        applications.insert(Application(job: job, status: .draft, updated: .now), at: 0)
    }

    /// Swipe left: the job leaves the deck.
    func skip(_ job: Job) {
        deck.removeAll { $0.id == job.id }
    }

    func move(_ application: Application, to status: ApplicationStatus) {
        guard let i = applications.firstIndex(where: { $0.id == application.id }) else { return }
        applications[i].status = status
        applications[i].updated = .now
    }

    func count(for status: ApplicationStatus) -> Int {
        applications.filter { $0.status == status }.count
    }

    func resetDeck() {
        let taken = Set(applications.map(\.job.id))
        deck = SampleData.jobs.filter { !taken.contains($0.id) }
        if deck.isEmpty { deck = SampleData.jobs }
    }
}
