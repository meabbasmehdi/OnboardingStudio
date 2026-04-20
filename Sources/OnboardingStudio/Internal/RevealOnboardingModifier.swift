import SwiftUI

struct RevealOnboardingModifier: ViewModifier {
    let isActive: Bool
    let offset: CGFloat
    let animation: Animation

    func body(content: Content) -> some View {
        content
            .opacity(isActive ? 1 : 0.3)
            .offset(y: isActive ? 0 : offset)
            .scaleEffect(isActive ? 1 : 0.98)
            .animation(animation, value: isActive)
    }
}

extension View {
    func onboardingReveal(
        isActive: Bool,
        offset: CGFloat = 24,
        animation: Animation
    ) -> some View {
        modifier(
            RevealOnboardingModifier(
                isActive: isActive,
                offset: offset,
                animation: animation
            )
        )
    }
}
