import SwiftUI

struct StackedCardsOnboardingSlide: View {
    let page: OnboardingPage
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let isActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            VStack(alignment: .leading, spacing: theme.spacing.stack) {
                if let eyebrow = page.eyebrow {
                    Text(eyebrow)
                        .font(theme.typography.eyebrow)
                        .kerning(1.2)
                        .foregroundStyle(theme.palette.textSecondary)
                }

                Text(page.title)
                    .font(theme.typography.title)
                    .foregroundStyle(theme.palette.textPrimary)

                Text(page.body)
                    .font(theme.typography.body)
                    .foregroundStyle(theme.palette.textSecondary)
            }
            .onboardingReveal(isActive: isActive, animation: theme.motion.pageAnimation)

            OnboardingMediaView(
                page: page,
                theme: theme,
                height: configuration.mediaHeight * 0.70,
                isActive: isActive
            )

            VStack(spacing: theme.spacing.compact) {
                ForEach(page.metrics) { metric in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(metric.label)
                                .font(theme.typography.caption)
                                .foregroundStyle(theme.palette.textSecondary)
                            Text(metric.value)
                                .font(theme.typography.metric)
                                .foregroundStyle(theme.palette.textPrimary)
                        }

                        Spacer()

                        Image(systemName: "arrow.up.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(page.accent.primary)
                    }
                    .padding(18)
                    .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: theme.chrome.cardRadius, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: theme.chrome.cardRadius, style: .continuous)
                            .stroke(theme.palette.border, lineWidth: 1)
                    )
                }
            }
            .onboardingReveal(isActive: isActive, offset: 20, animation: theme.motion.pageAnimation)
        }
    }
}
