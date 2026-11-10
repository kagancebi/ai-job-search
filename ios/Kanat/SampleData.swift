import Foundation

/// v1 runs entirely on this made-up data. v2 will replace it with the agent's real output.
enum SampleData {
    static let jobs: [Job] = [
        Job(
            title: "Senior ML Engineer",
            company: "Nimbus Labs",
            location: "İstanbul · Hibrit",
            salary: "€70–90K",
            score: 92,
            summary: "Üretimdeki tahmin modellerini ölçekleyen küçük bir ekip. Veri hattından servise kadar uçtan uca sahiplik.",
            why: ["Python ve PyTorch deneyimin birebir uyuyor", "Uçtan uca sahiplik istediğin ortam", "Hibrit çalışma"],
            gaps: ["Kubernetes deneyimi sınırlı"],
            tags: ["Python", "PyTorch", "MLOps", "AWS"],
            hue: 0.52
        ),
        Job(
            title: "AI Product Engineer",
            company: "Lumen Health",
            location: "Uzaktan · Avrupa",
            salary: "€65–80K",
            score: 86,
            summary: "Klinisyenler için LLM tabanlı araçlar. Hızlı prototip, kullanıcıyla sık görüşme, haftalık yayın.",
            why: ["Ajan ve LLM uygulama geçmişin", "Küçük, hızlı ekip", "Tam uzaktan"],
            gaps: ["Sağlık alanı deneyimi yok", "TypeScript ağırlıklı"],
            tags: ["LLM", "TypeScript", "RAG", "Healthtech"],
            hue: 0.78
        ),
        Job(
            title: "Data Scientist, Pricing",
            company: "Marmara Mobility",
            location: "İstanbul · Ofis",
            salary: "₺180–230K/ay",
            score: 74,
            summary: "Dinamik fiyatlama modelleri ve deney altyapısı. Büyük hacimli gerçek zamanlı veri.",
            why: ["İstatistik ve deney tasarımı geçmişin", "Büyük veri ile çalışma"],
            gaps: ["Tam zamanlı ofis", "Fiyatlama alanında yeni olurdun"],
            tags: ["SQL", "Python", "A/B test", "Spark"],
            hue: 0.08
        ),
        Job(
            title: "Applied Research Engineer",
            company: "Orbit Robotics",
            location: "Ankara · Hibrit",
            salary: "€60–75K",
            score: 68,
            summary: "Robot algısı için çok modlu modeller. Araştırmadan ürüne geçiş projeleri.",
            why: ["Araştırma temelli yaklaşım", "Yayın geçmişin bir artı"],
            gaps: ["Robotik deneyimi yok", "C++ gerekiyor"],
            tags: ["Vision", "C++", "PyTorch", "ROS"],
            hue: 0.62
        ),
        Job(
            title: "Staff Backend Engineer",
            company: "Zeytin Pay",
            location: "Uzaktan · TR",
            salary: "₺200–260K/ay",
            score: 61,
            summary: "Ödeme altyapısı, yüksek erişilebilirlik, olay yönetimi. Kıdemli teknik liderlik rolü.",
            why: ["Uzaktan çalışma", "Teknik liderlik fırsatı"],
            gaps: ["Go deneyimi yok", "Ödeme sistemleri yeni olur"],
            tags: ["Go", "PostgreSQL", "Kafka"],
            hue: 0.33
        ),
    ]

    static let applications: [Application] = {
        let day: TimeInterval = 86_400
        func job(_ i: Int) -> Job { jobs[i] }
        return [
            Application(job: job(0), status: .interview, updated: .now.addingTimeInterval(-1 * day)),
            Application(job: job(1), status: .sent, updated: .now.addingTimeInterval(-3 * day)),
            Application(job: job(2), status: .draft, updated: .now.addingTimeInterval(-5 * 3_600)),
            Application(job: job(3), status: .outcome, updated: .now.addingTimeInterval(-9 * day)),
        ]
    }()

    static let interviewCards: [InterviewCard] = [
        InterviewCard(
            category: .technical,
            question: "Üretimdeki bir modelin zamanla bozulduğunu nasıl fark eder ve ne yaparsın?",
            answer: "Girdi dağılımı ve tahmin dağılımı için izleme kurarım (drift). Eşik aşılınca uyarı gelir. Önce veri hattını kontrol ederim, sonra yeniden eğitim ya da geri alma kararı veririm."
        ),
        InterviewCard(
            category: .technical,
            question: "Bir RAG sisteminin kalitesini nasıl ölçersin?",
            answer: "Getirme ve üretimi ayrı ölçerim: getirme için recall@k, üretim için dayanaklılık ve cevap doğruluğu. Küçük bir altın veri seti ile her değişikliği regresyon testinden geçiririm."
        ),
        InterviewCard(
            category: .behavioral,
            question: "Belirsiz bir hedefle başladığın bir projeyi anlat.",
            answer: "Durum: hedef net değildi. Eylem: paydaşlarla başarı ölçütünü yazdım, en küçük işe yarar sürümü çıkardım. Sonuç: iki haftada ilk geri bildirim, kapsam netleşti."
        ),
        InterviewCard(
            category: .behavioral,
            question: "Bir hatadan ne öğrendin?",
            answer: "Doğrulamadan yayına aldığım bir veri dönüşümü raporu bozdu. Artık her dönüşüm için otomatik kontrol ve küçük bir canary çalıştırıyorum."
        ),
        InterviewCard(
            category: .ask,
            question: "Ekibe ilk 90 günde ne soracaksın?",
            answer: "Başarı bu rolde 6 ay sonra nasıl görünür? Ekibin en büyük teknik borcu ne? Kararlar nasıl alınır ve kim son sözü söyler?"
        ),
    ]

    static let profile = Profile(
        name: "Adın Soyadın",
        headline: "ML mühendisi · ajanlar ve uygulamalı yapay zekâ",
        location: "İstanbul",
        skills: ["Python", "PyTorch", "LLM", "RAG", "SQL", "MLOps", "Claude Code", "TypeScript"],
        sectors: ["Sağlık teknolojisi", "Fintech", "Geliştirici araçları"],
        dealbreakers: ["Tam zamanlı ofis", "Sürekli nöbet", "Belirsiz sahiplik"]
    )
}
