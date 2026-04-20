import SwiftUI

public struct OnboardingControls: View {
    let page: OnboardingPage
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let isFirstPage: Bool
    let isLastPage: Bool
    let onBack: () -> Void
    let onSkip: () -> Void
    let onNext: () -> Void

    public init(
        page: OnboardingPage,
        theme: OnboardingTheme,
        configuration: OnboardingConfiguration,
        isFirstPage: Bool,
        isLastPage: Bool,
        onBack: @escaping () -> Void,
        onSkip: @escaping () -> Void,
        onNext: @escaping () -> Void
    ) {
        self.page = page
        self.theme = theme
        self.configuration = configuration
        self.isFirstPage = isFirstPage
        self.isLastPage = isLastPage
        self.onBack = onBack
        self.onSkip = onSkip
        self.onNext = onNext
    }

    public var body: some View {
        Group {
            switch configuration.buttonLayout {
            case .horizontal:
                horizontalControls
            case .vertical:
                verticalControls
            }
        }
    }

    private var horizontalControls: some View {
        HStack(spacing: 12) {
            leadingAuxiliaryButton
            Spacer(minLength: 12)
            primaryButton
        }
    }

    private var verticalControls: some View {
        VStack(spacing: 12) {
            primaryButton
            leadingAuxiliaryButton
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder
    private var leadingAuxiliaryButton: some View {
        HStack(spacing: 12) {
            if configuration.showsBackButton {
                Button(action: onBack) {
                    Text(page.secondaryActionTitle ?? "Back")
                        .font(theme.typography.button)
                        .foregroundStyle(isFirstPage ? theme.palette.textSecondary.opacity(0.5) : theme.palette.textSecondary)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 14)
                        .background(.white.opacity(0.08), in: RoundedRectangle(cornerRadius: theme.chrome.controlRadius, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: theme.chrome.controlRadius, style: .continuous)
                                .stroke(theme.palette.border, lineWidth: 1)
                        )
                }
                .disabled(isFirstPage)
            }

            if configuration.showsSkipButton && !isLastPage {
                Button(action: onSkip) {
                    Text("Skip")
                        .font(theme.typography.button)
                        .foregroundStyle(theme.palette.textSecondary)
                }
            }
        }
    }

    private var primaryButton: some View {
        Button(action: onNext) {
            HStack(spacing: 12) {
                Text(isLastPage ? (page.primaryActionTitle ?? "Get Started") : (page.primaryActionTitle ?? "Next"))
                Image(systemName: isLastPage ? "checkmark.circle.fill" : "arrow.right")
            }
            .font(theme.typography.button)
            .foregroundStyle(theme.palette.accent)
            .padding(.horizontal, 22)
            .padding(.vertical, 16)
            .background(.white, in: RoundedRectangle(cornerRadius: theme.chrome.controlRadius, style: .continuous))
            .shadow(color: theme.chrome.shadowColor.opacity(0.5), radius: 16, y: 10)
        }
    }
}
