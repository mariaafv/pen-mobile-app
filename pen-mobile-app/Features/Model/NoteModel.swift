import Foundation

struct Note {
  let id: UUID
  let title: String
  let description: String
  let createdAt: Date
  
  init(title: String, description: String) {
    self.id = UUID()
    self.title = title
    self.description = description
    self.createdAt = Date()
  }
}
