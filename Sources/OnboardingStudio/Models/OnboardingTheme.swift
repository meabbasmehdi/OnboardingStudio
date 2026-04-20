import SwiftUI

public struct OnboardingTheme {
    public struct Palette {
        public var backgroundTop: Color
        public var backgroundBottom: Color
        public var floatingGlow: Color
        public var surface: Color
        public var surfaceSecondary: Color
        public var accent: Color
        public var accentSecondary: Color
        public var textPrimary: Color
        public var textSecondary: Color
        public var indicatorInactive: Color
        public var border: Color

        public init(
            backgroundTop: Color,
            backgroundBottom: Color,
            floatingGlow: Color,
            surface: Color,
            surfaceSecondary: Color,
            accent: Color,
            accentSecondary: Color,
            textPrimary: Color,
            textSecondary: Color,
            indicatorInactive: Color,
            border: Color
        ) {
            self.backgroundTop = backgroundTop
            self.backgroundBottom = backgroundBottom
            self.floatingGlow = floatingGlow
            self.surface = surface
            self.surfaceSecondary = surfaceSecondary
            self.accent = accent
            self.accentSecondary = accentSecondary
            self.textPrimary = textPrimary
            self.textSecondary = textSecondary
            self.indicatorInactive = indicatorInactive
            self.border = border
        }
    }

    public struct Typography {
        public var eyebrow: Font
        public var title: Font
        public var body: Font
        public var metric: Font
        public var button: Font
        public var caption: Font

        public init(
            eyebrow: Font,
            title: Font,
            body: Font,
            metric: Font,
            button: Font,
            caption: Font
        ) {
            self.eyebrow = eyebrow
            self.title = title
            self.body = body
            self.metric = metric
            self.button = button
            self.caption = caption
        }
    }

    public struct Spacing {
        public var section: CGFloat
        public var card: CGFloat
        public var stack: CGFloat
        public var compact: CGFloat

        public init(
            section: CGFloat,
            card: CGFloat,
            stack: CGFloat,
            compact: CGFloat
        ) {
            self.section = section
            self.card = card
            self.stack = stack
            self.compact = compact
        }
    }

    public struct Chrome {
        public var heroRadius: CGFloat
        public var cardRadius: CGFloat
        public var controlRadius: CGFloat
        public var outlineOpacity: Double
        public var shadowColor: Color
        public var shadowRadius: CGFloat
        public var shadowY: CGFloat

        public init(
            heroRadius: CGFloat,
            cardRadius: CGFloat,
            controlRadius: CGFloat,
            outlineOpacity: Double,
            shadowColor: Color,
            shadowRadius: CGFloat,
            shadowY: CGFloat
        ) {
            self.heroRadius = heroRadius
            self.cardRadius = cardRadius
            self.controlRadius = controlRadius
            self.outlineOpacity = outlineOpacity
            self.shadowColor = shadowColor
            self.shadowRadius = shadowRadius
            self.shadowY = shadowY
        }
    }

    public struct Motion {
        public var pageResponse: Double
        public var pageDamping: Double
        public var contentEaseDuration: Double
        public var backgroundFloatDuration: Double
        public var parallaxFactor: CGFloat

        public init(
            pageResponse: Double,
            pageDamping: Double,
            contentEaseDuration: Double,
            backgroundFloatDuration: Double,
            parallaxFactor: CGFloat
        ) {
            self.pageResponse = pageResponse
            self.pageDamping = pageDamping
            self.contentEaseDuration = contentEaseDuration
            self.backgroundFloatDuration = backgroundFloatDuration
            self.parallaxFactor = parallaxFactor
        }

        public var pageAnimation: Animation {
            .spring(response: pageResponse, dampingFraction: pageDamping)
        }
    }

    public var name: String
    public var palette: Palette
    public var typography: Typography
    public var spacing: Spacing
    public var chrome: Chrome
    public var motion: Motion

    public init(
        name: String,
        palette: Palette,
        typography: Typography,
        spacing: Spacing,
        chrome: Chrome,
        motion: Motion
    ) {
        self.name = name
        self.palette = palette
        self.typography = typography
        self.spacing = spacing
        self.chrome = chrome
        self.motion = motion
    }
}

public extension OnboardingTheme {
    nonisolated(unsafe) static let studio = OnboardingTheme(
        name: "Studio",
        palette: .init(
            backgroundTop: Color(red: 0.07, green: 0.10, blue: 0.19),
            backgroundBottom: Color(red: 0.20, green: 0.13, blue: 0.33),
            floatingGlow: Color(red: 0.53, green: 0.82, blue: 1.00),
            surface: Color.white.opacity(0.14),
            surfaceSecondary: Color.white.opacity(0.08),
            accent: Color(red: 0.46, green: 0.89, blue: 0.98),
            accentSecondary: Color(red: 0.78, green: 0.58, blue: 0.98),
            textPrimary: Color.white,
            textSecondary: Color.white.opacity(0.72),
            indicatorInactive: Color.white.opacity(0.22),
            border: Color.white.opacity(0.20)
        ),
        typography: .init(
            eyebrow: .system(size: 12, weight: .semibold, design: .rounded),
            title: .system(size: 34, weight: .bold, design: .rounded),
            body: .system(size: 17, weight: .medium, design: .rounded),
            metric: .system(size: 24, weight: .bold, design: .rounded),
            button: .system(size: 16, weight: .semibold, design: .rounded),
            caption: .system(size: 13, weight: .medium, design: .rounded)
        ),
        spacing: .init(
            section: 28,
            card: 22,
            stack: 16,
            compact: 10
        ),
        chrome: .init(
            heroRadius: 34,
            cardRadius: 26,
            controlRadius: 22,
            outlineOpacity: 0.35,
            shadowColor: .black.opacity(0.22),
            shadowRadius: 30,
            shadowY: 14
        ),
        motion: .init(
            pageResponse: 0.5,
            pageDamping: 0.88,
            contentEaseDuration: 0.5,
            backgroundFloatDuration: 12,
            parallaxFactor: 0.13
        )
    )

    nonisolated(unsafe) static let sunrise = OnboardingTheme(
        name: "Sunrise",
        palette: .init(
            backgroundTop: Color(red: 0.98, green: 0.56, blue: 0.36),
            backgroundBottom: Color(red: 0.99, green: 0.84, blue: 0.59),
            floatingGlow: Color(red: 1.00, green: 0.97, blue: 0.80),
            surface: Color.white.opacity(0.20),
            surfaceSecondary: Color.white.opacity(0.10),
            accent: Color(red: 0.24, green: 0.18, blue: 0.41),
            accentSecondary: Color(red: 0.50, green: 0.25, blue: 0.75),
            textPrimary: Color(red: 0.12, green: 0.11, blue: 0.18),
            textSecondary: Color(red: 0.19, green: 0.16, blue: 0.26).opacity(0.74),
            indicatorInactive: Color.black.opacity(0.12),
            border: Color.white.opacity(0.28)
        ),
        typography: .init(
            eyebrow: .system(size: 12, weight: .semibold, design: .rounded),
            title: .system(size: 34, weight: .bold, design: .rounded),
            body: .system(size: 17, weight: .medium, design: .rounded),
            metric: .system(size: 24, weight: .bold, design: .rounded),
            button: .system(size: 16, weight: .semibold, design: .rounded),
            caption: .system(size: 13, weight: .medium, design: .rounded)
        ),
        spacing: .init(
            section: 28,
            card: 22,
            stack: 16,
            compact: 10
        ),
        chrome: .init(
            heroRadius: 34,
            cardRadius: 26,
            controlRadius: 22,
            outlineOpacity: 0.28,
            shadowColor: .black.opacity(0.18),
            shadowRadius: 24,
            shadowY: 10
        ),
        motion: .init(
            pageResponse: 0.45,
            pageDamping: 0.9,
            contentEaseDuration: 0.45,
            backgroundFloatDuration: 11,
            parallaxFactor: 0.10
        )
    )
}
