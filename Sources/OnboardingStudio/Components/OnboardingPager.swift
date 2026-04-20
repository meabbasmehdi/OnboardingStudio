import SwiftUI

public struct OnboardingPager<PageContent: View>: View {
    let pages: [OnboardingPage]
    @Binding var currentIndex: Int
    let theme: OnboardingTheme
    let configuration: OnboardingConfiguration
    let pageContent: (OnboardingPage, Bool) -> PageContent

    @GestureState private var dragTranslation: CGFloat = 0

    public init(
        pages: [OnboardingPage],
        currentIndex: Binding<Int>,
        theme: OnboardingTheme,
        configuration: OnboardingConfiguration,
        @ViewBuilder pageContent: @escaping (OnboardingPage, Bool) -> PageContent
    ) {
        self.pages = pages
        self._currentIndex = currentIndex
        self.theme = theme
        self.configuration = configuration
        self.pageContent = pageContent
    }

    public var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                    pageContent(page, index == currentIndex)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            .offset(x: -CGFloat(currentIndex) * proxy.size.width + dragTranslation)
            .animation(theme.motion.pageAnimation, value: currentIndex)
            .contentShape(Rectangle())
            .gesture(dragGesture(pageWidth: proxy.size.width))
        }
    }

    private func dragGesture(pageWidth: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: 10)
            .updating($dragTranslation) { value, state, _ in
                guard configuration.allowsSwipe else { return }
                state = value.translation.width
            }
            .onEnded { value in
                guard configuration.allowsSwipe else { return }
                currentIndex = OnboardingSwipeResolver.targetIndex(
                    currentIndex: currentIndex,
                    translation: value.translation.width,
                    predictedEndTranslation: value.predictedEndTranslation.width,
                    pageWidth: pageWidth,
                    pageCount: pages.count
                )
            }
    }
}
