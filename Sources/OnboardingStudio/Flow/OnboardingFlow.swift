import SwiftUI

public struct OnboardingFlowContext {
    public let index: Int
    public let totalCount: Int
    public let isCurrent: Bool
    public let isLastPage: Bool
    public let theme: OnboardingTheme
    public let configuration: OnboardingConfiguration
}

public struct OnboardingFlow<CustomPageContent: View>: View {
    let pages: [OnboardingPage]
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let onFinish: () -> Void
    let customPageContent: ((OnboardingPage, OnboardingFlowContext) -> CustomPageContent)?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @StateObject private var flowState: OnboardingFlowState

    public init(
        pages: [OnboardingPage],
        theme: OnboardingTheme = .studio,
        configuration: OnboardingConfiguration = .default,
        onFinish: @escaping () -> Void
    ) where CustomPageContent == EmptyView {
        self.pages = pages
        self.theme = theme
        self.configuration = configuration
        self.onFinish = onFinish
        self.customPageContent = nil
        _flowState = StateObject(wrappedValue: OnboardingFlowState(pageCount: max(pages.count, 1)))
    }

    public init(
        pages: [OnboardingPage],
        theme: OnboardingTheme = .studio,
        configuration: OnboardingConfiguration = .default,
        onFinish: @escaping () -> Void,
        @ViewBuilder pageContent: @escaping (OnboardingPage, OnboardingFlowContext) -> CustomPageContent
    ) {
        self.pages = pages
        self.theme = theme
        self.configuration = configuration
        self.onFinish = onFinish
        self.customPageContent = pageContent
        _flowState = StateObject(wrappedValue: OnboardingFlowState(pageCount: max(pages.count, 1)))
    }

    public var body: some View {
        let activePage = pages[safe: flowState.currentIndex] ?? OnboardingPage.samplePages[0]

        ZStack {
            OnboardingBackground(theme: theme, accent: activePage.accent)

            VStack(spacing: theme.spacing.stack) {
                if configuration.indicatorPlacement == .top {
                    topChrome(page: activePage)
                }

                OnboardingPager(
                    pages: pages,
                    currentIndex: Binding(
                        get: { flowState.currentIndex },
                        set: { flowState.setIndex($0) }
                    ),
                    theme: theme,
                    configuration: configuration
                ) { page, isCurrent in
                    OnboardingPageContainer(
                        page: page,
                        theme: theme,
                        configuration: configuration,
                        isActive: isCurrent,
                        customContent: customPageContent.map { builder in
                            {
                                AnyView(
                                    builder(
                                        page,
                                        OnboardingFlowContext(
                                            index: pages.firstIndex(where: { $0.id == page.id }) ?? 0,
                                            totalCount: pages.count,
                                            isCurrent: isCurrent,
                                            isLastPage: page.id == pages.last?.id,
                                            theme: theme,
                                            configuration: configuration
                                        )
                                    )
                                )
                            }
                        }
                    )
                }

                if configuration.indicatorPlacement == .bottom {
                    topChrome(page: activePage)
                }

                OnboardingControls(
                    page: activePage,
                    theme: theme,
                    configuration: configuration,
                    isFirstPage: flowState.isFirstPage,
                    isLastPage: flowState.isLastPage,
                    onBack: { withMotion { flowState.goBack() } },
                    onSkip: onFinish,
                    onNext: nextAction
                )
                .padding(.horizontal, configuration.contentPadding.leading)
                .padding(.bottom, configuration.contentPadding.bottom)
            }
        }
    }

    @ViewBuilder
    private func topChrome(page: OnboardingPage) -> some View {
        HStack {
            OnboardingPageIndicator(
                total: pages.count,
                currentIndex: flowState.currentIndex,
                theme: theme
            )

            Spacer()

            if !page.badges.isEmpty {
                Text(page.badges.first ?? theme.name)
                    .font(theme.typography.caption)
                    .foregroundStyle(theme.palette.textSecondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.white.opacity(0.08), in: Capsule())
                    .overlay(Capsule().stroke(theme.palette.border, lineWidth: 1))
            }
        }
        .padding(.horizontal, configuration.contentPadding.leading)
        .padding(.top, 16)
    }

    private func nextAction() {
        if flowState.isLastPage {
            onFinish()
        } else {
            withMotion {
                _ = flowState.advance()
            }
        }
    }

    private func withMotion(_ updates: () -> Void) {
        if reduceMotion {
            updates()
        } else {
            withAnimation(theme.motion.pageAnimation, updates)
        }
    }
}

private extension Array {
    subscript(safe index: Int) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
