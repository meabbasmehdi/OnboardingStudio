import SwiftUI

public struct OnboardingPageContainer: View {
    let page: OnboardingPage
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let isActive: Bool
    let customContent: (() -> AnyView)?

    public init(
        page: OnboardingPage,
        theme: OnboardingTheme,
        configuration: OnboardingConfiguration,
        isActive: Bool,
        customContent: (() -> AnyView)? = nil
    ) {
        self.page = page
        self.theme = theme
        self.configuration = configuration
        self.isActive = isActive
        self.customContent = customContent
    }

    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: configuration.interPageSpacing) {
                if let customContent {
                    customContent()
                } else {
                    templateContent
                }
            }
            .padding(configuration.contentPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(page.accessibility.label ?? page.title)
        .accessibilityHint(page.accessibility.hint ?? page.body)
    }

    @ViewBuilder
    private var templateContent: some View {
        switch page.layout {
        case .hero:
            HeroOnboardingSlide(
                page: page,
                theme: theme,
                configuration: configuration,
                isActive: isActive
            )
        case .featureSplit:
            FeatureSplitOnboardingSlide(
                page: page,
                theme: theme,
                configuration: configuration,
                isActive: isActive
            )
        case .stackedCards:
            StackedCardsOnboardingSlide(
                page: page,
                theme: theme,
                configuration: configuration,
                isActive: isActive
            )
        }
    }
}
