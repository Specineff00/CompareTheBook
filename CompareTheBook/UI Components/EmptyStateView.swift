import SwiftUI

struct EmptyStateView: View {
    let title: String
    let retryMessage: String
    let loadBooksAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 50))
                .foregroundColor(.blue)

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            Text(retryMessage)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Load Books", action: loadBooksAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension EmptyStateView {
    static func scienceFiction(_ action: @escaping () -> Void) -> Self {
        .init(
            title: "No Books Yet",
            retryMessage: "Tap the button below to load science fiction books",
            loadBooksAction: action
        )
    }
}
