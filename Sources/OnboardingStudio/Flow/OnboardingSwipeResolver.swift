import CoreGraphics

public enum OnboardingSwipeResolver {
    public static func targetIndex(
        currentIndex: Int,
        translation: CGFloat,
        predictedEndTranslation: CGFloat,
        pageWidth: CGFloat,
        pageCount: Int
    ) -> Int {
        guard pageWidth > 0, pageCount > 0 else { return currentIndex }

        let threshold = pageWidth * 0.22
        let velocityBias = predictedEndTranslation - translation

        if translation < -threshold || velocityBias < -threshold {
            return min(currentIndex + 1, pageCount - 1)
        }

        if translation > threshold || velocityBias > threshold {
            return max(currentIndex - 1, 0)
        }

        return currentIndex
    }
}
