import SwiftUI

public extension View {
    func tutorialSpotlight<ID: Hashable, Overlay: View>(
        selection: Binding<ID?>,
        orderedIDs: [ID],
        spotlightPadding: CGFloat = 8,
        cornerRadius: CGFloat = 28,
        @ViewBuilder overlay: @escaping (_ id: ID, _ actions: TutorialSpotlightActions) -> Overlay
    ) -> some View {
        modifier(
            TutorialSpotlightContainerModifier(
                selection: selection,
                orderedIDs: orderedIDs,
                spotlightPadding: spotlightPadding,
                cornerRadius: cornerRadius,
                overlay: overlay
            )
        )
    }

    func tutorialSpotlightSource<ID: Hashable>(id: ID) -> some View {
        modifier(TutorialSpotlightSourceModifier(id: id))
    }
}

public struct TutorialSpotlightActions {
    public let dismiss: () -> Void
    public let advance: () -> Void

    public init(dismiss: @escaping () -> Void, advance: @escaping () -> Void) {
        self.dismiss = dismiss
        self.advance = advance
    }
}

public enum SpotlightSequenceResolver {
    public static func nextSelection<ID: Equatable>(current: ID?, orderedIDs: [ID]) -> ID? {
        guard let current else { return orderedIDs.first }
        guard let index = orderedIDs.firstIndex(of: current) else { return nil }
        let nextIndex = orderedIDs.index(after: index)
        return nextIndex < orderedIDs.endIndex ? orderedIDs[nextIndex] : nil
    }
}

private struct TutorialSpotlightSourceModifier<ID: Hashable>: ViewModifier {
    let id: ID

    func body(content: Content) -> some View {
        content.anchorPreference(
            key: TutorialSpotlightPreferenceKey<ID>.self,
            value: .bounds
        ) { anchor in
            [id: anchor]
        }
    }
}

private struct TutorialSpotlightContainerModifier<ID: Hashable, Overlay: View>: ViewModifier {
    @Binding var selection: ID?

    let orderedIDs: [ID]
    let spotlightPadding: CGFloat
    let cornerRadius: CGFloat
    let overlay: (ID, TutorialSpotlightActions) -> Overlay

    @State private var currentFrame: CGRect = .zero
    @State private var overlaySize: CGSize = .zero

    func body(content: Content) -> some View {
        ZStack {
            content.coordinateSpace(name: TutorialSpotlightCoordinateSpace.name)
        }
        .overlayPreferenceValue(TutorialSpotlightPreferenceKey<ID>.self) { preferences in
            GeometryReader { proxy in
                ZStack {
                    Color.clear
                    overlayContent(preferences: preferences, proxy: proxy)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    @ViewBuilder
    private func overlayContent(
        preferences: [ID: Anchor<CGRect>],
        proxy: GeometryProxy
    ) -> some View {
        if let selected = selection, let anchor = preferences[selected] {
            let targetFrame = proxy[anchor]
            let focusFrame = targetFrame.insetBy(dx: -spotlightPadding, dy: -spotlightPadding)
            let displayedFocusFrame = currentFrame == .zero ? focusFrame : currentFrame

            let actions = TutorialSpotlightActions(
                dismiss: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selection = nil
                    }
                },
                advance: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selection = SpotlightSequenceResolver.nextSelection(
                            current: selection,
                            orderedIDs: orderedIDs
                        )
                    }
                }
            )

            let safeAreaInsets = proxy.safeAreaInsets
            let containerBounds = CGRect(
                origin: .zero,
                size: CGSize(
                    width: proxy.size.width + safeAreaInsets.leading + safeAreaInsets.trailing,
                    height: proxy.size.height + safeAreaInsets.top + safeAreaInsets.bottom
                )
            )
            let overlayFocusFrame = displayedFocusFrame.offsetBy(
                dx: safeAreaInsets.leading,
                dy: safeAreaInsets.top
            )

            ZStack(alignment: .topLeading) {
                TutorialSpotlightCutoutShape(
                    focusFrame: overlayFocusFrame,
                    cornerRadius: cornerRadius
                )
                .fill(.black.opacity(0.58), style: FillStyle(eoFill: true))
                .contentShape(.rect)
                .onTapGesture { actions.dismiss() }

                overlay(selected, actions)
                    .frame(maxWidth: min(320, containerBounds.width - 32))
                    .background {
                        GeometryReader { overlayProxy in
                            Color.clear.preference(
                                key: TutorialSpotlightOverlaySizePreferenceKey.self,
                                value: overlayProxy.size
                            )
                        }
                    }
                    .position(
                        overlayPosition(
                            for: overlayFocusFrame,
                            overlaySize: overlaySize,
                            in: containerBounds
                        )
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.96)))
            }
            .frame(width: containerBounds.width, height: containerBounds.height)
            .offset(x: -safeAreaInsets.leading, y: -safeAreaInsets.top)
            .onAppear {
                currentFrame = focusFrame
            }
            .onChange(of: focusFrame) { newValue in
                currentFrame = newValue
            }
            .onPreferenceChange(TutorialSpotlightOverlaySizePreferenceKey.self) { newValue in
                overlaySize = newValue
            }
            .animation(.spring(response: 0.38, dampingFraction: 0.88), value: selection)
            .animation(.spring(response: 0.38, dampingFraction: 0.88), value: currentFrame)
            .animation(.spring(response: 0.38, dampingFraction: 0.88), value: overlaySize)
        }
    }

    private func overlayPosition(
        for focusFrame: CGRect,
        overlaySize: CGSize,
        in container: CGRect
    ) -> CGPoint {
        let horizontalPadding: CGFloat = 16
        let verticalSpacing: CGFloat = 24
        let verticalPadding: CGFloat = 24
        let maxOverlayWidth = min(320, container.width - (horizontalPadding * 2))
        let measuredWidth = overlaySize.width > 0 ? overlaySize.width : maxOverlayWidth
        let measuredHeight = overlaySize.height > 0 ? overlaySize.height : 180
        let overlayWidth = min(measuredWidth, maxOverlayWidth)

        let centeredX = min(
            max(focusFrame.midX, container.minX + horizontalPadding + overlayWidth / 2),
            container.maxX - horizontalPadding - overlayWidth / 2
        )

        let preferredBelowY = focusFrame.maxY + verticalSpacing + measuredHeight / 2

        if preferredBelowY + measuredHeight / 2 <= container.maxY - verticalPadding {
            return CGPoint(x: centeredX, y: preferredBelowY)
        }

        let preferredAboveY = focusFrame.minY - verticalSpacing - measuredHeight / 2
        let clampedY = min(
            max(preferredAboveY, container.minY + verticalPadding + measuredHeight / 2),
            container.maxY - verticalPadding - measuredHeight / 2
        )

        return CGPoint(x: centeredX, y: clampedY)
    }
}

private struct TutorialSpotlightPreferenceKey<ID: Hashable>: PreferenceKey {
    static var defaultValue: [ID: Anchor<CGRect>] { [:] }

    static func reduce(value: inout [ID: Anchor<CGRect>], nextValue: () -> [ID: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { _, new in new })
    }
}

private struct TutorialSpotlightCutoutShape: Shape {
    let focusFrame: CGRect
    let cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)
        path.addPath(
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .path(in: focusFrame)
        )
        return path
    }
}

private struct TutorialSpotlightOverlaySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize { .zero }

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private enum TutorialSpotlightCoordinateSpace {
    static let name = "tutorialSpotlightCoordinateSpace"
}
