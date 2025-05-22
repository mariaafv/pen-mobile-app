import Foundation

protocol AddNoteViewModelProtocol: AnyObject {
  func saveNote(title: String, description: String)
}

protocol AddNoteNavigationDelegate: AnyObject {
  func didSaveNote(_ note: Note)
  func dismissAddNote()
}

class AddNoteViewModel {
  private weak var navigationDelegate: AddNoteNavigationDelegate?
  
  init(navigationDelegate: AddNoteNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
  }
}

extension AddNoteViewModel: AddNoteViewModelProtocol {
  func saveNote(title: String, description: String) {
    let note = Note(title: title, description: description)
    navigationDelegate?.didSaveNote(note)
    navigationDelegate?.dismissAddNote()
  }
}
