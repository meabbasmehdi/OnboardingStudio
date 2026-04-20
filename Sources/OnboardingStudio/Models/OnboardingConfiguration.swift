import SwiftUI

public struct OnboardingConfiguration {
    public enum IndicatorPlacement {
        case top
        case bottom
    }

    public enum ButtonLayout {
        case horizontal
        case vertical
    }

    public enum TransitionStyle {
        case immersive
        case parallax
        case cardStack
    }

    public var showsSkipButton: Bool
    public var showsBackButton: Bool
    public var allowsSwipe: Bool
    public var indicatorPlacement: IndicatorPlacement
    public var buttonLayout: ButtonLayout
    public var transitionStyle: TransitionStyle
    public var contentPadding: EdgeInsets
    public var mediaHeight: CGFloat
    public var interPageSpacing: CGFloat
    public var allowsVerticalBounce: Bool

    public init(
        showsSkipButton: Bool = true,
        showsBackButton: Bool = true,
        allowsSwipe: Bool = true,
        indicatorPlacement: IndicatorPlacement = .bottom,
        buttonLayout: ButtonLayout = .horizontal,
        transitionStyle: TransitionStyle = .immersive,
        contentPadding: EdgeInsets = EdgeInsets(top: 28, leading: 24, bottom: 28, trailing: 24),
        mediaHeight: CGFloat = 320,
        interPageSpacing: CGFloat = 22,
        allowsVerticalBounce: Bool = false
    ) {
        self.showsSkipButton = showsSkipButton
        self.showsBackButton = showsBackButton
        self.allowsSwipe = allowsSwipe
        self.indicatorPlacement = indicatorPlacement
        self.buttonLayout = buttonLayout
        self.transitionStyle = transitionStyle
        self.contentPadding = contentPadding
        self.mediaHeight = mediaHeight
        self.interPageSpacing = interPageSpacing
        self.allowsVerticalBounce = allowsVerticalBounce
    }

    public nonisolated(unsafe) static let `default` = OnboardingConfiguration()
}
