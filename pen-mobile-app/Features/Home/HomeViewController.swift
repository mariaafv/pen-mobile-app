import UIKit

class HomeViewController: UIViewController {

  private let customView = HomeView()
  private let viewModel: HomeViewModelProtocol
  
  init(viewModel: HomeViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = customView
    setupActions()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  func setupActions() {
    customView.continueButton.addTarget(self, action: #selector(didTapStart), for: UIControl.Event.touchUpInside)
  }
  
  @objc func didTapStart() {
    viewModel.nextStep()
  }
}

