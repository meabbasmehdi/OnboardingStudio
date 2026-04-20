import XCTest
@testable import SpotlightGuide

final class SpotlightSequenceResolverTests: XCTestCase {
    func testReturnsFirstSelectionWhenCurrentIsMissing() {
        let next = SpotlightSequenceResolver.nextSelection(
            current: nil as String?,
            orderedIDs: ["profile", "filters", "checkout"]
        )

        XCTAssertEqual(next, "profile")
    }

    func testReturnsNextSelectionWhenAvailable() {
        let next = SpotlightSequenceResolver.nextSelection(
            current: "filters",
            orderedIDs: ["profile", "filters", "checkout"]
        )

        XCTAssertEqual(next, "checkout")
    }

    func testReturnsNilAtEndOfSequence() {
        let next = SpotlightSequenceResolver.nextSelection(
            current: "checkout",
            orderedIDs: ["profile", "filters", "checkout"]
        )

        XCTAssertNil(next)
    }
}
