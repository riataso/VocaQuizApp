import Foundation
import SwiftData

class WordRepository {
    static let shared = WordRepository()
    private let modelContainer = try? ModelContainer(for: WordEntity.self)

    private init() {
        
    }

    @MainActor
    func create(_ word: String, _ content: String) {
        let wordItem = WordEntity(id: UUID(), content: content,word: word)
        modelContainer?.mainContext.insert(wordItem)
    }

    @MainActor
    func fetchAll() -> [WordEntity] {
        let descriptor = FetchDescriptor<WordEntity>()
        let fetchItems = try? modelContainer?.mainContext.fetch(descriptor)
                guard let fetchItems else {
                    // TODO: ハンドリング
                    return []
                }
                return fetchItems
    }

    @MainActor
    func fetch(targetId: UUID) async throws -> WordEntity? {
        return fetchAll().first(where: { $0.id == targetId })
    }

    @MainActor
    func delete(targetId: UUID) async {
        let deleteItem = fetchAll().first(where: { $0.id == targetId })
        modelContainer?.mainContext.delete(deleteItem!)
    }
}
