import SwiftUI
import OnboardingStudio
import SpotlightGuide

struct ShowcaseRootView: View {
    @State private var useSunriseTheme = false
    @State private var showSpotlightDemo = false
    @State private var didFinish = false

    private var theme: OnboardingTheme {
        useSunriseTheme ? .sunrise : .studio
    }

    var body: some View {
        NavigationStack {
            ZStack {
                if didFinish {
                    completionView
                } else {
                    OnboardingFlow(
                        pages: OnboardingPage.samplePages,
                        theme: theme,
                        configuration: .default,
                        onFinish: {
                            didFinish = true
                        }
                    ) { page, context in
                        VStack(alignment: .leading, spacing: context.theme.spacing.section) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    if let eyebrow = page.eyebrow {
                                        Text(eyebrow)
                                            .font(context.theme.typography.eyebrow)
                                            .foregroundStyle(context.theme.palette.textSecondary)
                                    }
                                    Text(page.title)
                                        .font(context.theme.typography.title)
                                        .foregroundStyle(context.theme.palette.textPrimary)
                                }

                                Spacer()

                                Circle()
                                    .fill(page.accent.primary.opacity(0.28))
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Image(systemName: "wand.and.stars")
                                            .foregroundStyle(page.accent.primary)
                                    )
                            }

                            OnboardingPageContainer(
                                page: page,
                                theme: context.theme,
                                configuration: context.configuration,
                                isActive: context.isCurrent
                            )
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(useSunriseTheme ? "Studio" : "Sunrise") {
                        useSunriseTheme.toggle()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Spotlight") {
                        showSpotlightDemo = true
                    }
                }
            }
            .sheet(isPresented: $showSpotlightDemo) {
                ShowcaseSpotlightDemoView()
            }
        }
    }

    private var completionView: some View {
        ZStack {
            LinearGradient(
                colors: [theme.palette.backgroundTop, theme.palette.backgroundBottom],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(theme.palette.accent)

                Text("Onboarding complete")
                    .font(theme.typography.title)
                    .foregroundStyle(theme.palette.textPrimary)

                Text("The showcase app can now branch into the real product experience.")
                    .font(theme.typography.body)
                    .foregroundStyle(theme.palette.textSecondary)
                    .multilineTextAlignment(.center)

                Button("Replay") {
                    didFinish = false
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 14)
                .background(.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .padding(24)
        }
    }
}
