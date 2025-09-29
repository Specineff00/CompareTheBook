extension EmptyStateView {
    static func scienceFiction(_ action: @escaping () -> Void) -> Self {
        .init(
            title: "No Books Yet",
            retryMessage: "Tap the button below to load science fiction books",
            loadBooksAction: action
        )
    }
}
