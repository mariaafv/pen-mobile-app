import Foundation

protocol YourNotesViewModelProtocol: AnyObject {
  var notes: [Note] { get }
  var onNotesUpdated: (() -> Void)? { get set }
  func callAddNote()
  func addNote(_ note: Note)
  func editNote(note: Note, index: Int)
  func updateNote(_ note: Note, at index: Int)
}

protocol YourNotesNavigationDelegate: AnyObject {
  func callAddNewNote()
  func editNote(note: Note, index: Int)
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

  func editNote(note: Note, index: Int) {
    navigationDelegate?.editNote(note: note, index: index)
  }

  func updateNote(_ note: Note, at index: Int) {
    guard index >= 0 && index < _notes.count else { return }
    _notes[index] = note
    onNotesUpdated?()
  }
}
