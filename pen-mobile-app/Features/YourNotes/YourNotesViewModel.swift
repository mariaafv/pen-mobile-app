import Foundation

protocol YourNotesViewModelProtocol: AnyObject {
  func callAddNote()
}

protocol YourNotesNavigationDelegate: AnyObject {
  func callAddNewNote()
}

class YourNotesViewModel {
  private weak var navigationDelegate: YourNotesNavigationDelegate?
  
  init(navigationDelegate: YourNotesNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
  }
}

extension YourNotesViewModel: YourNotesViewModelProtocol {
  func callAddNote() {
    navigationDelegate?.callAddNewNote()
  }
}
