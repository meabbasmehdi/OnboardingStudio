import SwiftUI

struct FeatureSplitOnboardingSlide: View {
    let page: OnboardingPage
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let isActive: Bool

    var body: some View {
        VStack(spacing: theme.spacing.section) {
            HStack(alignment: .top, spacing: theme.spacing.card) {
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
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: theme.spacing.compact) {
                    ForEach(page.badges, id: \.self) { badge in
                        Text(badge)
                            .font(theme.typography.caption)
                            .foregroundStyle(theme.palette.textPrimary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(.white.opacity(0.10), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(theme.palette.border, lineWidth: 1)
                            )
                    }
                }
            }
            .onboardingReveal(isActive: isActive, animation: theme.motion.pageAnimation)

            OnboardingMediaView(
                page: page,
                theme: theme,
                height: configuration.mediaHeight * 0.82,
                isActive: isActive
            )
            .onboardingReveal(isActive: isActive, animation: theme.motion.pageAnimation)
        }
    }
}
