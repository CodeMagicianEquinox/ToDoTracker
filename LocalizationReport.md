# ToDoTracker Localization Report

Class transcript notes:

The class discussion emphasized that language switching may not appear per-app in Settings on every Simulator/device setup, and that this assignment extends localization beyond text into image assets and locale-aware formatting. To make the work easy to demonstrate, ToDoTracker includes an in-app globe menu for System Default, English, Spanish, and French.

Task 1: localized strings

User-facing strings are managed in `ToDoTracker/Localizable.xcstrings` for English, Spanish, and French. This includes navigation labels, buttons, form labels, task placeholders, accessibility labels, default group names, default task names, the added description text, and the added call-to-action button. SwiftUI literals and `String(localized:)` load these values dynamically from the active locale.

Task 2: localized images/resources

The asset catalog now includes three language-specific banner image sets:

- `locale-banner-en`
- `locale-banner-es`
- `locale-banner-fr`

`TaskDetailView` displays the correct banner by reading the selected `AppLanguage` and loading that language's asset name. System Default falls back to the device locale and chooses English, Spanish, or French where available.

Task 3: locale-specific formats

`TaskDetailView` now shows a locale panel with:

- a full formatted date using `DateFormatter`
- the current time using `DateFormatter`
- an example decimal number using `NumberFormatter`

Each formatter receives the active `Locale`, so switching the in-app language changes date, time, and number formatting for English, Spanish, and French.

Verification:

`xcodebuild -scheme ToDoTracker -project ToDoTracker.xcodeproj -destination 'generic/platform=iOS' CODE_SIGNING_ALLOWED=NO build` succeeds. A Simulator-targeted build was also attempted, but the local CoreSimulator service reported that `simdiskimaged` was not responding, so the generic iOS build was used for verification.
