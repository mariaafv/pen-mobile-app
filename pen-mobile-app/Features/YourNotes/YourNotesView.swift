import UIKit

class YourNotesView: UIView {
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 180, height: 140)
    layout.minimumInteritemSpacing = 10
    layout.minimumLineSpacing = 15
    layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemGray6
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  let emptyStateLabel: UILabel = {
    let label = UILabel()
    label.text = "No notes yet\nTap + to create your first note"
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .systemGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .systemGray6
    
    addSubview(collectionView)
    addSubview(emptyStateLabel)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  func showEmptyState(_ show: Bool) {
    emptyStateLabel.isHidden = !show
    collectionView.isHidden = show
  }
}
