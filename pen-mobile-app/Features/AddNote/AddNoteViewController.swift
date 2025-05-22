import UIKit
import AVFoundation
import Speech

class AddNoteViewController: UIViewController {
  
  private let customView = AddNoteView()
  private let viewModel: AddNoteViewModelProtocol
  
  private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "pt-BR"))
  private let audioEngine = AVAudioEngine()
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?
  
  init(viewModel: AddNoteViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    self.view = customView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    requestTranscribePermissions()
    makeMicrophoneButtonClickable()
    setupSaveButton()
  }
  
  private func setupNavigationBar() {
    navigationItem.title = "New Note"
//    navigationItem.leftBarButtonItem = UIBarButtonItem(
//      barButtonSystemItem: .cancel,
//      target: self,
//      action: #selector(cancelTapped)
//    )
  }
  
  private func setupSaveButton() {
    customView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
  }
  
//  @objc private func cancelTapped() {
//    dismiss(animated: true)
//  }
  
  @objc private func saveButtonTapped() {
    let title = customView.noteName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    let description = customView.descriptionTextField.textColor == UIColor.placeholderText ? "" : customView.descriptionTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    
    if title.isEmpty && description.isEmpty {
      showAlert(message: "Please enter a title or description for your note.")
      return
    }
    
    viewModel.saveNote(title: title, description: description)
  }
  
  private func showAlert(message: String) {
    let alert = UIAlertController(title: "Empty Note", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
  }
  
  func requestTranscribePermissions() {
    SFSpeechRecognizer.requestAuthorization { authStatus in
      DispatchQueue.main.async {
        switch authStatus {
        case .authorized:
          print("Speech recognition authorized")
        case .denied, .restricted, .notDetermined:
          print("Speech recognition not authorized")
        @unknown default:
          fatalError()
        }
      }
    }
  }
  
  func makeMicrophoneButtonClickable() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(microphoneTapped))
    customView.microphoneButton.addGestureRecognizer(tapGestureRecognizer)
  }
  
  @objc func microphoneTapped() {
    if audioEngine.isRunning {
      stopRecording()
      customView.microphoneButton.tintColor = .systemGray
    } else {
      startRecording()
      customView.microphoneButton.tintColor = .systemRed
    }
  }
  
  func startRecording() {
    // Cancelar a task anterior
    if recognitionTask != nil {
      recognitionTask?.cancel()
      recognitionTask = nil
    }
    
    // Configurar a sessão de áudio
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
      try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    } catch {
      print("AudioSession properties weren't set because of an error.")
      return
    }
    
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    guard let recognitionRequest = recognitionRequest else {
      fatalError("Unable to create a recognition request")
    }
    
    recognitionRequest.shouldReportPartialResults = true
    
    let inputNode = audioEngine.inputNode
    
    recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
      guard let self = self else { return }
      
      var isFinal = false
      
      if let result = result {
        print("Transcription: \(result.bestTranscription.formattedString)")
        DispatchQueue.main.async {
          // Se o textView ainda tem o placeholder, limpe-o primeiro
          if self.customView.descriptionTextField.textColor == UIColor.placeholderText {
            self.customView.descriptionTextField.text = ""
            self.customView.descriptionTextField.textColor = UIColor.label
          }
          self.customView.descriptionTextField.text = result.bestTranscription.formattedString
        }
        isFinal = result.isFinal
      }
      
      if error != nil || isFinal {
        self.stopRecording()
        DispatchQueue.main.async {
          self.customView.microphoneButton.tintColor = .systemGray
        }
      }
    }
    
    let recordingFormat = inputNode.outputFormat(forBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
      self.recognitionRequest?.append(buffer)
    }
    
    audioEngine.prepare()
    
    do {
      try audioEngine.start()
    } catch {
      print("audioEngine couldn't start because of an error.")
    }
  }
  
  func stopRecording() {
    audioEngine.stop()
    recognitionRequest?.endAudio()
    recognitionTask = nil
    audioEngine.inputNode.removeTap(onBus: 0)
  }
}
