import SwiftUI

struct BookListView: View {
    @State private var viewModel: BookListViewModel

    init(viewModel: BookListViewModel = BookListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
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
                            ForEach(books) {
                                bookCell($0)
                            }
                        }
                    }
                }
            }
            .task {
                viewModel.loadSavedBooks()
            }
            .refreshable {
                guard !(viewModel.screenState == .loading) else { return }
                await viewModel.refreshBooks()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        viewModel.resetUserDefaults()
                    }
                }
            }
            .navigationTitle("Science Fiction")
        }
    }

    private func bookCell(_ book: Book) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)

                if !book.authors.isEmpty {
                    Text("by \(book.authors.map(\.name).joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            AsyncImage(url: book.mediumCoverImageURL) { phase in
                phase.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    BookListView()
}
