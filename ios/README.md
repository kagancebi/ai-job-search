# Kanat (iOS)

Mobile control panel for the job-search agent in this repo. v1 runs entirely on
made-up sample data (`Kanat/SampleData.swift`); v2 will talk to the agent.

Screens: **Keşfet** (swipe deck of ranked jobs), **Başvurular** (status pipeline),
**Mülakat** (flip-card interview prep), **Profil**.

## Build

Requires Xcode 15+ (iOS 17 target) and [XcodeGen](https://github.com/yonaskolb/XcodeGen).

```bash
brew install xcodegen
```

```bash
cd ios && xcodegen && open Kanat.xcodeproj
```

In Xcode: select the `Kanat` target → Signing & Capabilities → pick your Team,
and change the bundle identifier (`com.example.kanat`) to your own. Then run on a
simulator or device.

The `.xcodeproj` is generated from `project.yml` and is git-ignored.
