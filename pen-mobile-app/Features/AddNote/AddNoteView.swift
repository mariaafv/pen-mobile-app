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
  
  let saveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Save", for: .normal)
    button.backgroundColor = .appDarkGreen
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 12
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupTextViewDelegate()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupTextViewDelegate() {
    descriptionTextField.delegate = self
  }
  
  func setupView() {
    backgroundColor = .white
    
    addSubview(noteName)
    addSubview(descriptionTextField)
    addSubview(microphoneButton)
    addSubview(saveButton)
    
    NSLayoutConstraint.activate([
      noteName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
      noteName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      noteName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      noteName.heightAnchor.constraint(equalToConstant: 56),
      
      descriptionTextField.topAnchor.constraint(equalTo: noteName.bottomAnchor, constant: 10),
      descriptionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      descriptionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      descriptionTextField.heightAnchor.constraint(equalToConstant: 160),
      
      microphoneButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 10),
      microphoneButton.trailingAnchor.constraint(equalTo: descriptionTextField.trailingAnchor, constant: -10),
      microphoneButton.widthAnchor.constraint(equalToConstant: 24),
      microphoneButton.heightAnchor.constraint(equalToConstant: 24),
      
      saveButton.topAnchor.constraint(equalTo: microphoneButton.bottomAnchor, constant: 30),
      saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      saveButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

// MARK: - UITextViewDelegate
extension AddNoteView: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.placeholderText {
      textView.text = nil
      textView.textColor = UIColor.label
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "Enter your thoughts"
      textView.textColor = UIColor.placeholderText
    }
  }
}
