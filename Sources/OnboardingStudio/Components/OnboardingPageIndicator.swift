import SwiftUI

public struct OnboardingPageIndicator: View {
    let total: Int
    let currentIndex: Int
    let theme: OnboardingTheme

    public init(total: Int, currentIndex: Int, theme: OnboardingTheme) {
        self.total = total
        self.currentIndex = currentIndex
        self.theme = theme
    }

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                Capsule(style: .continuous)
                    .fill(index == currentIndex ? theme.palette.textPrimary : theme.palette.indicatorInactive)
                    .frame(width: index == currentIndex ? 28 : 10, height: 10)
                    .animation(theme.motion.pageAnimation, value: currentIndex)
            }
        }
        .padding(10)
        .background(.white.opacity(0.10), in: Capsule(style: .continuous))
        .overlay(Capsule(style: .continuous).stroke(theme.palette.border, lineWidth: 1))
    }
}
