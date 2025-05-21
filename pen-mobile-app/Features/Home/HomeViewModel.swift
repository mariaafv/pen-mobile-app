import Foundation

protocol HomeViewModelProtocol: AnyObject {
  func nextStep()
}

protocol HomeNavigationDelegate: AnyObject {
  func goToYourNotes()
}

class HomeViewModel {
  private weak var navigationDelegate: HomeNavigationDelegate?
  
  init(navigationDelegate: HomeNavigationDelegate? = nil) {
    self.navigationDelegate = navigationDelegate
  }
}

extension HomeViewModel: HomeViewModelProtocol {
  func nextStep() {
    navigationDelegate?.goToYourNotes()
  }
}
