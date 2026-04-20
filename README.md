# OnboardingStudio

`OnboardingStudio` is a premium SwiftUI onboarding library for iOS apps. It packages polished full-screen onboarding flows, motion-rich transitions, themeable UI primitives, and an optional spotlight tutorial module into a reusable Swift Package designed for open-source distribution.

`SpotlightGuide` is shipped alongside the main library to preserve the existing spotlight onboarding pattern as a separate module.

## Highlights

- Premium full-screen onboarding flows with editorial-style layouts
- Modular components for paging, indicators, controls, backgrounds, and media
- Theme system for colors, typography, spacing, controls, and motion
- Gesture-driven navigation with configurable skip/back/next behavior
- Builder-based customization when built-in templates are not enough
- Separate `SpotlightGuide` product for contextual live-screen tutorials
- MIT licensed and ready for GitHub publishing

## Requirements

- iOS 16.0+
- Xcode 16+
- SwiftUI

## Installation

Add the package using Swift Package Manager:

```swift
.package(url: "https://github.com/meabbasmehdi/OnboardingStudio.git", from: "1.0.0")
```

Then import the library:

```swift
import OnboardingStudio
import SpotlightGuide
```

## Quick Start

```swift
import SwiftUI
import OnboardingStudio

struct DemoScreen: View {
    @State private var isComplete = false

    private let pages = OnboardingPage.samplePages

    var body: some View {
        OnboardingFlow(
            pages: pages,
            theme: .studio,
            configuration: .default,
            onFinish: {
                isComplete = true
            }
        )
    }
}
```

## Public API

### High-Level Flow

```swift
OnboardingFlow(
    pages: pages,
    theme: .studio,
    configuration: .default,
    onFinish: { ... }
)
```

### Reusable Primitives

- `OnboardingPager`
- `OnboardingPageContainer`
- `OnboardingPageIndicator`
- `OnboardingControls`
- `OnboardingBackground`
- `OnboardingMediaView`

### Core Models

- `OnboardingPage`
- `OnboardingTheme`
- `OnboardingConfiguration`
- `OnboardingFlowState`

### Spotlight Module

```swift
view
    .tutorialSpotlight(selection: $selection, orderedIDs: ids) { id, actions in
        SpotlightCard(id: id, actions: actions)
    }
```

## Styling and Customization

`OnboardingStudio` is designed for custom branding without touching the library internals.

- Create a custom `OnboardingTheme` to control color palette, typography, spacing, chrome, and motion.
- Use `OnboardingConfiguration` to adjust swipe support, indicator placement, safe-area behavior, and button layout.
- Supply a custom page builder closure to `OnboardingFlow` for fully bespoke slide content while reusing the flow container, background, pager, and controls.

## Built-In Layouts

- `hero`: for large statements and bold visual anchors
- `featureSplit`: for product explainers with balanced text and media
- `stackedCards`: for card-heavy premium onboarding treatments

## Repository Structure

```text
OnboardingStudio/
  Package.swift
  Sources/
    OnboardingStudio/
    SpotlightGuide/
  Tests/
    OnboardingStudioTests/
    SpotlightGuideTests/
  Examples/
    OnboardingShowcase/
```

## Showcase App

The repository includes a source-ready showcase app under [Examples/OnboardingShowcase](Examples/OnboardingShowcase). It demonstrates:

- a premium branded onboarding flow
- theme switching
- custom page composition
- gesture navigation
- the separate spotlight module

## Migration Note

This library supersedes the earlier `TutorialSpotlight` package identity.

- `OnboardingStudio` is the new main library for full-screen onboarding flows.
- `SpotlightGuide` retains the spotlight tutorial API so existing consumers can migrate without losing that interaction pattern.

## Documentation

- Package docs: [Sources/OnboardingStudio/OnboardingStudio.docc](Sources/OnboardingStudio/OnboardingStudio.docc)
- Contributing guide: [CONTRIBUTING.md](CONTRIBUTING.md)
- Changelog: [CHANGELOG.md](CHANGELOG.md)
