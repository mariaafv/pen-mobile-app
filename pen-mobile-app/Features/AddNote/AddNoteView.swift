import UIKit

class AddNoteView: UIView {
  
  let noteName: UITextField = {
    var noteName = UITextField()
    noteName.borderStyle = .roundedRect
    noteName.placeholder = "Your note name"
    noteName.layer.cornerRadius = 23
    noteName.translatesAutoresizingMaskIntoConstraints = false
    return noteName
  }()
  
  let descriptionTextField: UITextView = {
    let descriptionTextField = UITextView()
    descriptionTextField.layer.borderWidth = 1
    descriptionTextField.layer.borderColor = UIColor.systemGray5.cgColor
    descriptionTextField.layer.cornerRadius = 8
    descriptionTextField.layer.masksToBounds = true
    descriptionTextField.font = .systemFont(ofSize: 16)
    descriptionTextField.text = "Enter your thoughts"
    descriptionTextField.textColor = UIColor.placeholderText
    descriptionTextField.isUserInteractionEnabled = true
    descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
    return descriptionTextField
  }()
  
  let microphoneButton: UIImageView = {
    let microphoneButton = UIImageView()
    microphoneButton.image = UIImage(systemName: "microphone.fill")
    microphoneButton.isUserInteractionEnabled = true
    microphoneButton.tintColor = .systemGray
    microphoneButton.translatesAutoresizingMaskIntoConstraints = false
    return microphoneButton
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubview(noteName)
    addSubview(descriptionTextField)
    addSubview(microphoneButton)
    
    NSLayoutConstraint.activate([
      noteName.topAnchor.constraint(equalTo: topAnchor, constant: 60),
      noteName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      noteName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      noteName.heightAnchor.constraint(equalToConstant: 56),
      
      descriptionTextField.topAnchor.constraint(equalTo: noteName.bottomAnchor, constant: 10),
      descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      descriptionTextField.widthAnchor.constraint(equalToConstant: 360),
      descriptionTextField.heightAnchor.constraint(equalToConstant: 160),
      
      microphoneButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10),
      microphoneButton.trailingAnchor.constraint(equalTo: descriptionTextField.trailingAnchor, constant: -10)
    ])
  }
}
