import SwiftUI

struct BookListView: View {
    @State private var viewModel: BookListViewModel

    init(viewModel: BookListViewModel = BookListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack {
                switch viewModel.screenState {
                case .loading:
                    ProgressView("Loading books...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case let .error(message):
                    ErrorView(
                        message: message,
                        retryAction: {
                            Task {
                                await viewModel.refreshBooks()
                            }
                        }
                    )
                case let .loaded(books):
                    if books.isEmpty {
                        EmptyStateView.scienceFiction {
                            Task {
                                await viewModel.loadBooks()
                            }
                        }
                    } else {
                        List(books) {
                            bookCell($0)
                        }
                    }
                }
            }
        }
        .task {
            viewModel.loadSavedBooks()
            await viewModel.loadBooks()
        }
        .refreshable {
            guard !(viewModel.screenState == .loading) else { return }
            await viewModel.refreshBooks()
        }
    }

    private func bookCell(_ book: Book) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.headline)
                .lineLimit(2)

            if !book.authors.isEmpty {
                Text("by \(book.authors.map(\.name).joined(separator: ", "))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookListView()
}
