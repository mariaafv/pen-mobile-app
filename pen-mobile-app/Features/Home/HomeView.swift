import UIKit

class HomeView: UIView {
  
  let penTitle: UILabel = {
    var penTitle = UILabel()
    penTitle.text = "pen."
    penTitle.font = UIFont(name: "Poppins-Bold", size: 28)
    penTitle.translatesAutoresizingMaskIntoConstraints = false
    return penTitle
  }()
  
  let penImage: UIImageView = {
    var penImage = UIImageView(image: UIImage(named: "pen"))
    penImage.contentMode = .scaleAspectFit
    penImage.clipsToBounds = true
    penImage.translatesAutoresizingMaskIntoConstraints = false
    return penImage
  }()
  
  let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.isPagingEnabled = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  let pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.numberOfPages = 3
    pageControl.currentPage = 0
    pageControl.currentPageIndicatorTintColor = .black
    pageControl.pageIndicatorTintColor = .lightGray
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    return pageControl
  }()
  
  let continueButton: UIButton = {
    var continueButton = UIButton()
    continueButton.setTitle("Start", for: UIControl.State.normal)
    continueButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 18)
    continueButton.tintColor = .white
    continueButton.backgroundColor = .black
    continueButton.layer.cornerRadius = 23
    continueButton.translatesAutoresizingMaskIntoConstraints = false
    return continueButton
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupCarousel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubview(penTitle)
    addSubview(penImage)
    addSubview(scrollView)
    addSubview(pageControl)
    addSubview(continueButton)
    
    NSLayoutConstraint.activate([
      penTitle.topAnchor.constraint(equalTo: topAnchor, constant: 120),
      penTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      penImage.topAnchor.constraint(equalTo: penTitle.bottomAnchor, constant: 60),
      penImage.leadingAnchor.constraint(equalTo: leadingAnchor),
      penImage.trailingAnchor.constraint(equalTo: trailingAnchor),
      penImage.heightAnchor.constraint(equalToConstant: 240),
      
      scrollView.topAnchor.constraint(equalTo: penImage.bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.heightAnchor.constraint(equalToConstant: 80),
      
      pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
      pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
      continueButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
      continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
      continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
      continueButton.heightAnchor.constraint(equalToConstant: 56)
    ])
  }
  
  private func setupCarousel() {
    let phrases = [
      "Organize your thoughts effortlessly.",
      "Keep your ideas flowing.",
      "Stay productive anywhere."
    ]
    
    for (index, phrase) in phrases.enumerated() {
      let label = UILabel()
      label.text = phrase
      label.textAlignment = .center
      label.font = UIFont(name: "Poppins-Regular", size: 16)
      label.numberOfLines = 0
      label.translatesAutoresizingMaskIntoConstraints = false
      
      let container = UIView()
      container.translatesAutoresizingMaskIntoConstraints = false
      container.addSubview(label)
      
      scrollView.addSubview(container)
      
      NSLayoutConstraint.activate([
        container.topAnchor.constraint(equalTo: scrollView.topAnchor),
        container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        container.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
        label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
        label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
        label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
      ])
      
      if index == 0 {
        container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
      } else {
        container.leadingAnchor.constraint(equalTo: scrollView.subviews[index - 1].trailingAnchor).isActive = true
      }
      
      if index == phrases.count - 1 {
        container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
      }
    }
    
    scrollView.delegate = self
  }
}

// MARK: - UIScrollViewDelegate
extension HomeView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let page = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
    pageControl.currentPage = page
  }
}
