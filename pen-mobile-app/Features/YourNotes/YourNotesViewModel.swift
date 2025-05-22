import Foundation

protocol YourNotesViewModelProtocol: AnyObject {
  var notes: [Note] { get }
  var onNotesUpdated: (() -> Void)? { get set }
  func callAddNote()
  func addNote(_ note: Note)
}

protocol YourNotesNavigationDelegate: AnyObject {
  func callAddNewNote()
}

class YourNotesViewModel {
  private weak var navigationDelegate: YourNotesNavigationDelegate?
  private var _notes: [Note] = []
  
  var onNotesUpdated: (() -> Void)?
  
  init(navigationDelegate: YourNotesNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
  }
}

extension YourNotesViewModel: YourNotesViewModelProtocol {
  var notes: [Note] {
    return _notes
  }
  
  func callAddNote() {
    navigationDelegate?.callAddNewNote()
  }
  
  func addNote(_ note: Note) {
    _notes.insert(note, at: 0)
    onNotesUpdated?()
  }
}
