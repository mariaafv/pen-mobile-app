import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
  static let identifier = "NoteCollectionViewCell"
  
  // Array de cores para os stickers
  private let stickerColors: [UIColor] = [
    UIColor(red: 1.0, green: 0.9, blue: 0.7, alpha: 1.0),    // Amarelo claro
    UIColor(red: 0.9, green: 1.0, blue: 0.9, alpha: 1.0),    // Verde claro
    UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 1.0),    // Rosa claro
    UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1.0),    // Azul claro
    UIColor(red: 1.0, green: 0.95, blue: 0.9, alpha: 1.0),   // Laranja claro
    UIColor(red: 0.95, green: 0.9, blue: 1.0, alpha: 1.0),   // Roxo claro
    UIColor(red: 0.9, green: 1.0, blue: 1.0, alpha: 1.0),    // Ciano claro
    UIColor(red: 1.0, green: 1.0, blue: 0.9, alpha: 1.0)     // Creme
  ]
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .black
    label.numberOfLines = 2
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .darkGray
    label.numberOfLines = 3
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .systemGray2
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
    layer.cornerRadius = 12
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.1
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(dateLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      
      dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
      dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
    ])
  }
  
  func configure(with note: Note, at indexPath: IndexPath) {
    titleLabel.text = note.title.isEmpty ? "Untitled" : note.title
    descriptionLabel.text = note.description
    
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    dateLabel.text = formatter.string(from: note.createdAt)
    
    let colorIndex = indexPath.item % stickerColors.count
    backgroundColor = stickerColors[colorIndex]
  }
}
