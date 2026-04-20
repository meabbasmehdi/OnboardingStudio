import SwiftUI
import SpotlightGuide

struct ShowcaseSpotlightDemoView: View {
    enum Step: String, CaseIterable {
        case profile
        case filters
        case checkout

        var title: String {
            switch self {
            case .profile: return "Profile"
            case .filters: return "Filters"
            case .checkout: return "Checkout"
            }
        }

        var message: String {
            switch self {
            case .profile: return "Place tutorial context directly on live UI elements."
            case .filters: return "Keep the user oriented with dimmed surroundings and a focused target."
            case .checkout: return "Finish the flow without sending users through detached slides."
            }
        }
    }

    @State private var selection: Step? = .profile

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                HStack {
                    Button("Profile") {
                        selection = .profile
                    }
                    .tutorialSpotlightSource(id: Step.profile)

                    Spacer()
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Smart Filters")
                        .font(.headline)
                    HStack(spacing: 12) {
                        chip("Budget")
                        chip("Family")
                        chip("Food")
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                .tutorialSpotlightSource(id: Step.filters)

                Spacer()

                Button("Continue") {
                    selection = .checkout
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(.blue.gradient, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .tutorialSpotlightSource(id: Step.checkout)
            }
            .padding(24)
            .navigationTitle("Spotlight Demo")
        }
        .tutorialSpotlight(selection: $selection, orderedIDs: Step.allCases) { id, actions in
            VStack(alignment: .leading, spacing: 16) {
                Text(id.title)
                    .font(.headline)

                Text(id.message)
                    .foregroundStyle(.secondary)

                HStack {
                    Button("Close") {
                        actions.dismiss()
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Button(id == .checkout ? "Finish" : "Next") {
                        actions.advance()
                    }
                    .fontWeight(.semibold)
                }
            }
            .padding(20)
            .background(.white, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.12), radius: 20, y: 10)
        }
    }

    private func chip(_ title: String) -> some View {
        Text(title)
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.blue.opacity(0.10), in: Capsule())
    }
}
