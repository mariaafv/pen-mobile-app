import UIKit

final class HomeRouter {
  weak var navigationController: UINavigationController?
  private weak var homeViewController: UIViewController?
  
  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }
  
  public func start() -> UIViewController {
    let viewModel = HomeViewModel(navigationDelegate: self)
    let homeViewController = HomeViewController(viewModel: viewModel)
    self.homeViewController = homeViewController
    return homeViewController
  }
}

extension HomeRouter: HomeNavigationDelegate {
  func goToYourNotes() {
    let viewModel = YourNotesViewModel(navigationDelegate: self)
    let viewController = YourNotesViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension HomeRouter: YourNotesNavigationDelegate {
  func callAddNewNote() {
    let viewModel = AddNoteViewModel()
    let viewController = AddNoteViewController(viewModel: viewModel)
    viewController.modalPresentationStyle = .pageSheet
    if let sheet = viewController.sheetPresentationController {
        sheet.detents = [.custom(resolver: { _ in 340 })]
        sheet.prefersGrabberVisible = true
    }
    navigationController?.present(viewController, animated: true)
  }
}
