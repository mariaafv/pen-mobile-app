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

// MARK: - Navegação a partir da Home

extension HomeRouter: HomeNavigationDelegate {
  func goToYourNotes() {
    let viewModel = YourNotesViewModel(navigationDelegate: self)
    self.yourNotesViewModel = viewModel
    let viewController = YourNotesViewController(viewModel: viewModel)
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - Navegação a partir da tela de notas

extension HomeRouter: YourNotesNavigationDelegate {
  func callAddNewNote() {
    let viewModel = AddNoteViewModel(navigationDelegate: self)
    let viewController = AddNoteViewController(viewModel: viewModel)
    
    let navController = UINavigationController(rootViewController: viewController)
    navController.modalPresentationStyle = .pageSheet
    
    if let sheet = navController.sheetPresentationController {
      sheet.detents = [.medium(), .large()]
      sheet.prefersGrabberVisible = true
    }
    
    navigationController?.present(navController, animated: true)
  }
  
  func editNote(note: Note, index: Int) {
    let viewModel = AddNoteViewModel(navigationDelegate: self, previousNote: note, index: index)
    let viewController = AddNoteViewController(viewModel: viewModel)
    
    let navController = UINavigationController(rootViewController: viewController)
    navController.modalPresentationStyle = .pageSheet
    
    if let sheet = navController.sheetPresentationController {
      sheet.detents = [.medium(), .large()]
      sheet.prefersGrabberVisible = true
    }
    
    navigationController?.present(navController, animated: true)
  }
}

// MARK: - Navegação de retorno da AddNote

extension HomeRouter: AddNoteNavigationDelegate {
  func didSaveNote(_ note: Note, at index: Int?) {
    if let index = index {
      yourNotesViewModel?.updateNote(note, at: index)
    } else {
      yourNotesViewModel?.addNote(note)
    }
  }

  func dismissAddNote() {
    navigationController?.dismiss(animated: true)
  }
}
