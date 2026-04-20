import Foundation

@MainActor
public final class OnboardingFlowState: ObservableObject {
    @Published public private(set) var currentIndex: Int
    public let pageCount: Int

    public init(pageCount: Int, initialIndex: Int = 0) {
        self.pageCount = max(pageCount, 1)
        self.currentIndex = min(max(initialIndex, 0), max(pageCount - 1, 0))
    }

    public var isFirstPage: Bool {
        currentIndex == 0
    }

    public var isLastPage: Bool {
        currentIndex >= pageCount - 1
    }

    @discardableResult
    public func advance() -> Bool {
        guard !isLastPage else { return false }
        currentIndex += 1
        return true
    }

    public func goBack() {
        currentIndex = max(currentIndex - 1, 0)
    }

    public func skipToEnd() {
        currentIndex = max(pageCount - 1, 0)
    }

    public func reset() {
        currentIndex = 0
    }

    public func setIndex(_ newValue: Int) {
        currentIndex = min(max(newValue, 0), max(pageCount - 1, 0))
    }
}
