import SwiftUI

public struct OnboardingMediaView: View {
    let page: OnboardingPage
    let theme: OnboardingTheme
    let height: CGFloat
    let isActive: Bool

    public init(
        page: OnboardingPage,
        theme: OnboardingTheme,
        height: CGFloat,
        isActive: Bool
    ) {
        self.page = page
        self.theme = theme
        self.height = height
        self.isActive = isActive
    }

    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: theme.chrome.heroRadius, style: .continuous)
                .fill(.white.opacity(0.09))
                .background(
                    RoundedRectangle(cornerRadius: theme.chrome.heroRadius, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [
                                    page.accent.primary.opacity(0.40),
                                    page.accent.secondary.opacity(0.22)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .blur(radius: 10)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: theme.chrome.heroRadius, style: .continuous)
                        .strokeBorder(theme.palette.border, lineWidth: 1)
                )

            switch page.media {
            case let .symbol(systemName, rotation):
                symbolView(systemName: systemName, rotation: rotation)
            case let .cards(cards):
                cardsView(cards)
            case .none:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .shadow(
            color: theme.chrome.shadowColor,
            radius: theme.chrome.shadowRadius,
            y: theme.chrome.shadowY
        )
    }

    private func symbolView(systemName: String, rotation: Double) -> some View {
        ZStack {
            Circle()
                .fill(page.accent.primary.opacity(0.28))
                .frame(width: 150, height: 150)
                .blur(radius: 6)
                .offset(x: -40, y: -28)

            Circle()
                .fill(page.accent.secondary.opacity(0.25))
                .frame(width: 120, height: 120)
                .offset(x: 58, y: 42)
                .blur(radius: 3)

            Image(systemName: systemName)
                .font(.system(size: 84, weight: .semibold))
                .foregroundStyle(
                    LinearGradient(
                        colors: [page.accent.primary, page.accent.secondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .rotationEffect(.degrees(rotation))
                .scaleEffect(isActive ? 1 : 0.92)
                .shadow(color: page.accent.glow.opacity(0.35), radius: 24, y: 10)
        }
        .animation(theme.motion.pageAnimation, value: isActive)
    }

    private func cardsView(_ cards: [OnboardingPage.MediaCard]) -> some View {
        ZStack {
            ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                HStack(spacing: 14) {
                    Image(systemName: card.systemImage)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundStyle(page.accent.primary)
                        .frame(width: 48, height: 48)
                        .background(.white.opacity(0.14), in: RoundedRectangle(cornerRadius: 16, style: .continuous))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(card.title)
                            .font(theme.typography.body.weight(.semibold))
                            .foregroundStyle(theme.palette.textPrimary)
                        Text(card.subtitle)
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.palette.textSecondary)
                    }

                    Spacer()
                }
                .padding(18)
                .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(theme.palette.border, lineWidth: 1)
                )
                .offset(x: CGFloat(index * 8), y: CGFloat(index * 28))
                .rotationEffect(.degrees(Double(index) * 2.8 - 2.8))
                .scaleEffect(isActive ? 1 : 0.98)
            }
        }
        .padding(.horizontal, 28)
        .padding(.top, 10)
        .animation(theme.motion.pageAnimation, value: isActive)
    }
}
