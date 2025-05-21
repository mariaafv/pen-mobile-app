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
    requestTranscribePermissions()
    makeMicrophoneButtonClickable()
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
     // customView.microphoneButton.setTitle("Start Recording", for: .normal) // ajuste conforme seu botão
    } else {
      startRecording()
      //customView.microphoneButton.setTitle("Stop Recording", for: .normal)
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
          self.customView.descriptionTextField.text = result.bestTranscription.formattedString
        }
        isFinal = result.isFinal
      }
      
      if error != nil || isFinal {
        self.stopRecording()
        //self.customView.microphoneButton.setTitle("Start Recording", for: .normal)
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
