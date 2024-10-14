import Foundation

class WordItemUseCase {

    @MainActor
    func createWordItem(_ word: String,_ content: String) {
        WordRepository.shared.create(word, content)
    }

    @MainActor
    func fetchWordItems() -> [WordEntity] {
        return WordRepository.shared.fetchAll()
    }

    @MainActor
    func fetchWordItem(_ id: UUID) async throws -> WordEntity? {
        return try await WordRepository.shared.fetch(targetId: id)
    }

    @MainActor
    func deleteWordItem(_ id: UUID) async {
        await WordRepository.shared.delete(targetId: id)
    }
}

