import Foundation

protocol AddNoteViewModelProtocol: AnyObject {
  func saveNote(title: String, description: String)
  var previousNote: Note? { get }
}

protocol AddNoteNavigationDelegate: AnyObject {
  func didSaveNote(_ note: Note, at index: Int?)
  func dismissAddNote()
}

class AddNoteViewModel {
  private weak var navigationDelegate: AddNoteNavigationDelegate?
  var previousNote: Note?
  var editingIndex: Int? = nil
  
  init(navigationDelegate: AddNoteNavigationDelegate? = nil, previousNote: Note? = nil, index: Int? = nil) {
    self.navigationDelegate = navigationDelegate
    self.previousNote = previousNote
    self.editingIndex = index
  }
}

extension AddNoteViewModel: AddNoteViewModelProtocol {
  func saveNote(title: String, description: String) {
    let note = Note(title: title, description: description)
    navigationDelegate?.didSaveNote(note, at: editingIndex)
    navigationDelegate?.dismissAddNote()
  }
}
