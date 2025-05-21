import Foundation

protocol AddNoteViewModelProtocol: AnyObject {
}

protocol AddNoteNavigationDelegate: AnyObject {
  func callAddNewNote()
}

class AddNoteViewModel {
  private weak var navigationDelegate: AddNoteNavigationDelegate?
  
  init(navigationDelegate: AddNoteNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
  }
}

extension AddNoteViewModel: AddNoteViewModelProtocol {
  
}
