import SwiftUI

struct HeroOnboardingSlide: View {
    let page: OnboardingPage
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let isActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.section) {
            OnboardingMediaView(
                page: page,
                theme: theme,
                height: configuration.mediaHeight,
                isActive: isActive
            )
            .onboardingReveal(isActive: isActive, animation: theme.motion.pageAnimation)

            textBlock
                .onboardingReveal(isActive: isActive, offset: 18, animation: theme.motion.pageAnimation)
        }
    }

    private var textBlock: some View {
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
                .fixedSize(horizontal: false, vertical: true)

            badges
            metrics
        }
    }

    @ViewBuilder
    private var badges: some View {
        if !page.badges.isEmpty {
            HStack(spacing: theme.spacing.compact) {
                ForEach(page.badges, id: \.self) { badge in
                    Text(badge)
                        .font(theme.typography.caption)
                        .foregroundStyle(theme.palette.textPrimary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.white.opacity(0.10), in: Capsule())
                        .overlay(Capsule().stroke(theme.palette.border, lineWidth: 1))
                }
            }
        }
    }

    @ViewBuilder
    private var metrics: some View {
        if !page.metrics.isEmpty {
            HStack(spacing: theme.spacing.compact) {
                ForEach(page.metrics) { metric in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(metric.value)
                            .font(theme.typography.metric)
                            .foregroundStyle(theme.palette.textPrimary)
                        Text(metric.label)
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.palette.textSecondary)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(theme.palette.border, lineWidth: 1)
                    )
                }
            }
        }
    }
}
