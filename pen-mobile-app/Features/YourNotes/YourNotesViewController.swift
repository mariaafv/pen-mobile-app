import UIKit

class YourNotesViewController: UIViewController {
  private let customView = YourNotesView()
  
  override func loadView() {
    self.view = customView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
  }
  
  func setupNavigationBar() {
    // Criar o label
    let titleLabel = UILabel()
    titleLabel.text = "Tasks"
    titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
    titleLabel.textColor = .black
    
    // Criar um container para o label e descer ele
    let titleContainer = UIView()
    titleContainer.backgroundColor = .clear
    titleContainer.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
      titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 12), // Desce 6pt
      titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor)
    ])
    
    let titleItem = UIBarButtonItem(customView: titleContainer)
    navigationItem.leftBarButtonItems = [titleItem] // ou adicione o botão de voltar se necessário
    
    // Botões de ação à direita
    let addButton = makeCircleButton(systemName: "plus", action: #selector(didTapAdd))
    let filterButton = makeCircleButton(systemName: "slider.horizontal.3", action: #selector(didTapFilter))
    
    let stackView = UIStackView(arrangedSubviews: [addButton, filterButton])
    stackView.axis = .horizontal
    stackView.spacing = 12
    stackView.backgroundColor = .systemGray6
    
    let rightContainer = UIView()
    rightContainer.backgroundColor = .systemGray6
    rightContainer.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: rightContainer.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: rightContainer.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: rightContainer.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: rightContainer.trailingAnchor)
    ])
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightContainer)
    
    // Estilo padrão da barra
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.backgroundColor = .systemGray6
  }
  
  
  
  private func makeCircleButton(systemName: String, action: Selector) -> UIButton {
    let button = UIButton(type: .system)
    let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .bold)
    let image = UIImage(systemName: systemName, withConfiguration: config)
    button.setImage(image, for: .normal)
    button.tintColor = .black
    button.backgroundColor = .systemGray5
    button.layer.cornerRadius = 20
    button.clipsToBounds = true
    
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalToConstant: 40),
      button.heightAnchor.constraint(equalToConstant: 40)
    ])
    
    button.addTarget(self, action: action, for: .touchUpInside)
    return button
  }
  
  @objc private func didTapAdd() {
    print("Adicionar tarefa")
  }
  
  @objc private func didTapFilter() {
    print("Abrir filtros")
  }
}
