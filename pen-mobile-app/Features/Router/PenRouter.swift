import UIKit

final class HomeRouter {
  weak var navigationController: UINavigationController?
  private weak var homeViewController: UIViewController?
  private var yourNotesViewModel: YourNotesViewModel?
  
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
    self.yourNotesViewModel = viewModel
    let viewController = YourNotesViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension HomeRouter: YourNotesNavigationDelegate {
  func callAddNewNote() {
    let viewModel = AddNoteViewModel(navigationDelegate: self)
    let viewController = AddNoteViewController(viewModel: viewModel)
    
    // Apresentar em um navigation controller para ter botão de cancelar
    let navController = UINavigationController(rootViewController: viewController)
    navController.modalPresentationStyle = .pageSheet
    
    if let sheet = navController.sheetPresentationController {
      sheet.detents = [.medium(), .large()]
      sheet.prefersGrabberVisible = true
    }
    
    navigationController?.present(navController, animated: true)
  }
  
  
}

extension HomeRouter: AddNoteNavigationDelegate {
  func didSaveNote(_ note: Note) {
    yourNotesViewModel?.addNote(note)
  }
  
  func dismissAddNote() {
    navigationController?.dismiss(animated: true)
  }
}
