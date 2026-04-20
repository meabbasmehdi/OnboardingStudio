import XCTest
@testable import OnboardingStudio

@MainActor
final class OnboardingFlowStateTests: XCTestCase {
    func testAdvanceStopsAtLastPage() {
        let state = OnboardingFlowState(pageCount: 3)

        XCTAssertTrue(state.advance())
        XCTAssertEqual(state.currentIndex, 1)

        XCTAssertTrue(state.advance())
        XCTAssertEqual(state.currentIndex, 2)

        XCTAssertFalse(state.advance())
        XCTAssertEqual(state.currentIndex, 2)
    }

    func testBackAndResetClampIndex() {
        let state = OnboardingFlowState(pageCount: 4, initialIndex: 2)

        state.goBack()
        XCTAssertEqual(state.currentIndex, 1)

        state.goBack()
        state.goBack()
        XCTAssertEqual(state.currentIndex, 0)

        state.reset()
        XCTAssertEqual(state.currentIndex, 0)
    }

    func testSkipMovesToFinalPage() {
        let state = OnboardingFlowState(pageCount: 5)
        state.skipToEnd()
        XCTAssertEqual(state.currentIndex, 4)
        XCTAssertTrue(state.isLastPage)
    }

    func testSwipeResolverAdvancesAndRetreats() {
        XCTAssertEqual(
            OnboardingSwipeResolver.targetIndex(
                currentIndex: 0,
                translation: -140,
                predictedEndTranslation: -200,
                pageWidth: 320,
                pageCount: 3
            ),
            1
        )

        XCTAssertEqual(
            OnboardingSwipeResolver.targetIndex(
                currentIndex: 1,
                translation: 150,
                predictedEndTranslation: 210,
                pageWidth: 320,
                pageCount: 3
            ),
            0
        )
    }

    func testDefaultConfigurationMatchesV1Expectations() {
        let configuration = OnboardingConfiguration.default

        XCTAssertTrue(configuration.showsSkipButton)
        XCTAssertTrue(configuration.showsBackButton)
        XCTAssertTrue(configuration.allowsSwipe)
        XCTAssertEqual(configuration.mediaHeight, 320)
        XCTAssertEqual(configuration.interPageSpacing, 22)
    }
}
