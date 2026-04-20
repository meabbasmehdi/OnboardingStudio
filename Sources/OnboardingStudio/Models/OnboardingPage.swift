import SwiftUI

public struct OnboardingPage: Identifiable {
    public struct Accessibility {
        public var label: String?
        public var hint: String?

        public init(label: String? = nil, hint: String? = nil) {
            self.label = label
            self.hint = hint
        }
    }

    public struct Metric: Identifiable {
        public let id = UUID()
        public var value: String
        public var label: String

        public init(value: String, label: String) {
            self.value = value
            self.label = label
        }
    }

    public struct Accent {
        public var primary: Color
        public var secondary: Color
        public var glow: Color

        public init(primary: Color, secondary: Color, glow: Color) {
            self.primary = primary
            self.secondary = secondary
            self.glow = glow
        }
    }

    public struct MediaCard: Identifiable {
        public let id = UUID()
        public var title: String
        public var subtitle: String
        public var systemImage: String

        public init(title: String, subtitle: String, systemImage: String) {
            self.title = title
            self.subtitle = subtitle
            self.systemImage = systemImage
        }
    }

    public enum Layout {
        case hero
        case featureSplit
        case stackedCards
    }

    public enum Media {
        case symbol(systemName: String, rotation: Double = 0)
        case cards([MediaCard])
        case none
    }

    public var id: String
    public var eyebrow: String?
    public var title: String
    public var body: String
    public var badges: [String]
    public var metrics: [Metric]
    public var media: Media
    public var layout: Layout
    public var accent: Accent
    public var primaryActionTitle: String?
    public var secondaryActionTitle: String?
    public var accessibility: Accessibility

    public init(
        id: String,
        eyebrow: String? = nil,
        title: String,
        body: String,
        badges: [String] = [],
        metrics: [Metric] = [],
        media: Media = .none,
        layout: Layout = .hero,
        accent: Accent,
        primaryActionTitle: String? = nil,
        secondaryActionTitle: String? = nil,
        accessibility: Accessibility = .init()
    ) {
        self.id = id
        self.eyebrow = eyebrow
        self.title = title
        self.body = body
        self.badges = badges
        self.metrics = metrics
        self.media = media
        self.layout = layout
        self.accent = accent
        self.primaryActionTitle = primaryActionTitle
        self.secondaryActionTitle = secondaryActionTitle
        self.accessibility = accessibility
    }
}

public extension OnboardingPage {
    nonisolated(unsafe) static let samplePages: [OnboardingPage] = [
        OnboardingPage(
            id: "craft",
            eyebrow: "DESIGNED FOR PRODUCT TEAMS",
            title: "Make onboarding feel like part of the product.",
            body: "Compose immersive first-run experiences with premium motion, adaptive layouts, and reusable styling tokens that ship cleanly across apps.",
            badges: ["Premium UI", "SwiftUI", "Reusable"],
            metrics: [
                .init(value: "3", label: "Templates"),
                .init(value: "100%", label: "Themeable"),
                .init(value: "0", label: "Runtime deps")
            ],
            media: .symbol(systemName: "sparkles.rectangle.stack.fill"),
            layout: .hero,
            accent: .init(
                primary: Color(red: 0.41, green: 0.90, blue: 0.99),
                secondary: Color(red: 0.76, green: 0.53, blue: 0.97),
                glow: Color(red: 0.49, green: 0.76, blue: 0.99)
            ),
            primaryActionTitle: "Start Designing",
            secondaryActionTitle: "Skip intro",
            accessibility: .init(
                label: "Introduction to OnboardingStudio",
                hint: "Swipe or tap next to continue."
            )
        ),
        OnboardingPage(
            id: "motion",
            eyebrow: "SMOOTH BY DEFAULT",
            title: "Gesture-first flows with polished motion and hierarchy.",
            body: "Use the built-in pager, controls, and page containers to get swipe interactions, active indicators, and tactile transitions without rebuilding onboarding from scratch.",
            badges: ["Gestures", "Indicators", "Controls"],
            metrics: [
                .init(value: "0.5s", label: "Page spring"),
                .init(value: "16", label: "Component atoms")
            ],
            media: .cards([
                .init(title: "Swipe", subtitle: "Interactive paging", systemImage: "hand.draw.fill"),
                .init(title: "Guide", subtitle: "Skip, back, next", systemImage: "arrow.forward.circle.fill"),
                .init(title: "Theme", subtitle: "One source of truth", systemImage: "paintpalette.fill")
            ]),
            layout: .featureSplit,
            accent: .init(
                primary: Color(red: 0.13, green: 0.84, blue: 0.76),
                secondary: Color(red: 0.35, green: 0.55, blue: 0.96),
                glow: Color(red: 0.48, green: 0.94, blue: 0.89)
            ),
            primaryActionTitle: "Show the system",
            secondaryActionTitle: "Skip intro"
        ),
        OnboardingPage(
            id: "publish",
            eyebrow: "OPEN SOURCE READY",
            title: "Ship portfolio-worthy onboarding, then publish the package.",
            body: "Document the API, keep the showcase app close to the package, and preserve the spotlight module for contextual tutorials inside the same repo.",
            badges: ["DocC", "Showcase", "Spotlight"],
            metrics: [
                .init(value: "2", label: "Library products"),
                .init(value: "MIT", label: "License"),
                .init(value: "v1", label: "Ready")
            ],
            media: .cards([
                .init(title: "OnboardingStudio", subtitle: "Main library", systemImage: "rectangle.stack.fill.badge.plus"),
                .init(title: "SpotlightGuide", subtitle: "Live-screen tutorials", systemImage: "scope"),
                .init(title: "Showcase", subtitle: "Presentable demo", systemImage: "iphone.gen3")
            ]),
            layout: .stackedCards,
            accent: .init(
                primary: Color(red: 1.00, green: 0.67, blue: 0.42),
                secondary: Color(red: 1.00, green: 0.40, blue: 0.64),
                glow: Color(red: 1.00, green: 0.83, blue: 0.54)
            ),
            primaryActionTitle: "Get Started",
            secondaryActionTitle: "Back"
        )
    ]
}
