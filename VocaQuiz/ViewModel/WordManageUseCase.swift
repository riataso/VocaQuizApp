import Foundation

class WordItemUseCase {
    private let repository: WordRepository

    init() {
        let wordRepository = WordRepository()
        self.repository = wordRepository
    }

    @MainActor
    func onTapCreateButton(_ word: String,_ content: String) {
        repository.create(word, content)
    }

    @MainActor
    func fetchWordItems() -> [WordEntity] {
        return repository.fetchAll()
    }

    @MainActor
    func fetchWordItem(_ id: UUID) async throws -> WordEntity? {
        return try await repository.fetch(targetId: id)
    }
}

