import SwiftUI

public struct OnboardingBackground: View {
    let theme: OnboardingTheme
    let accent: OnboardingPage.Accent

    public init(theme: OnboardingTheme, accent: OnboardingPage.Accent) {
        self.theme = theme
        self.accent = accent
    }

    public var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    theme.palette.backgroundTop,
                    theme.palette.backgroundBottom
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(accent.glow.opacity(0.42))
                .blur(radius: 60)
                .frame(width: 220, height: 220)
                .offset(x: -110, y: -260)

            Circle()
                .fill(theme.palette.floatingGlow.opacity(0.24))
                .blur(radius: 72)
                .frame(width: 260, height: 260)
                .offset(x: 140, y: 220)

            RoundedRectangle(cornerRadius: 44, style: .continuous)
                .fill(.white.opacity(0.05))
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(18))
                .offset(x: 170, y: -180)
                .blur(radius: 2)
        }
        .ignoresSafeArea()
    }
}
