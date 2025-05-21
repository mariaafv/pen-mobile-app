import UIKit

class AddNoteViewController: UIViewController {

  private let customView = AddNoteView()
  
  override func loadView() {
    self.view = customView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
}

