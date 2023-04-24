import UIKit
import Foundation
import Hero
 
final class NewNoteViewController: UIViewController {
  // MARK: - Private Properties
  private let aButton = UIButton(type: .system)
  private let aBigButton = UIButton(type: .system)
  private let slider = UISlider()
  private let blackButton = UIButton(type: .system)
  private let brownButton = UIButton(type: .system)
  private let greenButton = UIButton(type: .system)
  private let whiteButton = UIButton(type: .system)
  private let fontTextField = UITextField()
  private let fontPicker = UIPickerView()
  private let titleOfNoteTextView = UITextView()
  private let textOfNoteTextView = UITextView()
  private let fontsArray = ["Helvetica Neue", "Chalkboard SE", "Baskerville"]
  private var fontWeight = "regular"
  private var color = ".black"
  private var fontSize = "18"
  private var font = "Helvetica Neue"
  private let titleOfNotePlaceholder = "Введите заголовок (до 25 символов)"
  private let textOfNotePlaceholder = "Введите текст заметки"
  
  // MARK: - Public Properties
  weak var delegate: CreateNoteDelegate?
 
  //MARK: - UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewDidLayoutSubviews() {
  super.viewDidLayoutSubviews()
    blackButton.layer.cornerRadius = blackButton.frame.width / 2
    brownButton.layer.cornerRadius = brownButton.frame.width / 2
    greenButton.layer.cornerRadius = greenButton.frame.width / 2
    whiteButton.layer.cornerRadius = whiteButton.frame.width / 2
  }
 
  //MARK: - Visual Components
  private func setupNavigationController() {
    navigationItem.title = "Новая"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(addNewNote))
    navigationItem.rightBarButtonItem?.isEnabled = false
  }
  
  // MARK: - Private Methods
  private func setupView() {
    setupNavigationController()
    setupAButton()
    setupABigButton()
    setupBlackButton()
    setupBrownButton()
    setupGreenButton()
    setupWhiteButton()
    setupSlider()
    setupFontTextField()
    setupFontPicker()
    addSubviews()
    addTarget()
    setupSelfView()
    setupTitleOfNoteTextView()
    setupTextOfNoteTextView()
    setupAButtonConstraints()
    setupABigButtonConstraints()
    setupBlackButtonConstraints()
    setupBrownButtonConstraints()
    setupGreenButtonConstraints()
    setupWhiteButtonConstraints()
    setupSliderConstraints()
    setupFontTextFieldConstraints()
    setupTitleOfNoteTextViewConstraints()
    setupTextOfNoteTextViewConstraints()
  }
  
  private func addSubviews() {
    [aButton, aBigButton, blackButton, brownButton, greenButton, whiteButton,slider, fontTextField, titleOfNoteTextView, textOfNoteTextView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func addTarget() {
    aButton.addTarget(self, action: #selector(changeFontWeight), for: .touchUpInside)
    aBigButton.addTarget(self, action: #selector(changeFontWeight), for: .touchUpInside)
    blackButton.addTarget(self, action: #selector(changeTextColor), for: .touchUpInside)
    brownButton.addTarget(self, action: #selector(changeTextColor), for: .touchUpInside)
    greenButton.addTarget(self, action: #selector(changeTextColor), for: .touchUpInside)
    whiteButton.addTarget(self, action: #selector(changeTextColor), for: .touchUpInside)
    slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
   }
 
  private func setupSelfView() {
    view.backgroundColor = .white
    hideKeyboardWhenTappedAround()
  }
 
  private func setupAButton() {
    aButton.layer.borderWidth = 1
    aButton.layer.borderColor = UIColor.black.cgColor
    aButton.setTitle("A", for: .normal)
    aButton.tintColor = .black
    aButton.titleLabel?.font = .systemFont(ofSize: 17)
    shadow(aButton)
  }
 
  private func setupABigButton() {
    aBigButton.layer.borderWidth = 1
    aBigButton.layer.borderColor = UIColor.black.cgColor
    aBigButton.setTitle("A", for: .normal)
    aBigButton.tintColor = .black
    aBigButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    shadow(aBigButton)
  }
  
  private func setupBlackButton() {
    blackButton.backgroundColor = .black
    blackButton.clipsToBounds = true
    shadow(blackButton)
  }

  private func setupBrownButton() {
    brownButton.backgroundColor = .brown
    brownButton.clipsToBounds = true
    shadow(brownButton)
  }
  
  private func setupGreenButton() {
    greenButton.backgroundColor = .green
    greenButton.clipsToBounds = true
    shadow(greenButton)
  }
  
  private func setupWhiteButton() {
    whiteButton.backgroundColor = .white
    whiteButton.clipsToBounds = true
    shadow(whiteButton)
  }
 
  private func setupSlider() {
    let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
    let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
    slider.frame = CGRect(x: 220, y: 103, width: 154, height: 23)
    slider.minimumValue = Float(17)
    slider.maximumValue = Float(23)
    slider.tintColor = .black
    slider.minimumTrackTintColor = .black
    slider.setThumbImage(image, for: .normal)
    shadow(slider)
  }
  
  private func setupFontTextField() {
    let toolFontTextField = UIToolbar()
    toolFontTextField.sizeToFit()
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector (endEditing))
    toolFontTextField.setItems([flexSpace, doneButton], animated: true)
    fontTextField.inputAccessoryView = toolFontTextField
    fontTextField.frame = CGRect(x: 30, y: 190, width: 334, height: 31)
    fontTextField.inputView = fontPicker
    fontTextField.text = "Выберите шрифт"
    fontTextField.borderStyle = .roundedRect
    fontTextField.textAlignment = .center
    shadow(fontTextField)
  }
  
  private func setupFontPicker() {
    fontPicker.delegate = self
    fontPicker.dataSource = self
  }

  private func setupTitleOfNoteTextView() {
    titleOfNoteTextView.delegate = self
    titleOfNoteTextView.autocorrectionType = .yes
    titleOfNoteTextView.text = titleOfNotePlaceholder
    titleOfNoteTextView.textColor = .lightGray
    titleOfNoteTextView.font = .systemFont(ofSize: 17, weight: .bold)
    titleOfNoteTextView.layer.cornerRadius = 10
    titleOfNoteTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    titleOfNoteTextView.layer.shadowColor = UIColor.gray.cgColor;
    titleOfNoteTextView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
    titleOfNoteTextView.layer.shadowOpacity = 0.9
    titleOfNoteTextView.layer.shadowRadius = 5
    titleOfNoteTextView.layer.masksToBounds = false
    titleOfNoteTextView.addDoneButton(title: "Готово", target: self, selector: #selector(endEditing))
  }
  
  private func setupTextOfNoteTextView() {
    textOfNoteTextView.delegate = self
    textOfNoteTextView.autocorrectionType = .yes
    textOfNoteTextView.text = textOfNotePlaceholder
    textOfNoteTextView.textColor = .lightGray
    textOfNoteTextView.backgroundColor = .init(red: 240/255, green: 181/255, blue: 13/255, alpha: 1)
    textOfNoteTextView.font = .systemFont(ofSize: 18, weight: .medium)
    textOfNoteTextView.layer.cornerRadius = 15
    textOfNoteTextView.textContainerInset = UIEdgeInsets(top: 20, left: 15, bottom: 10, right: 10)
    textOfNoteTextView.layer.masksToBounds = false
    guard let textFnt = textOfNoteTextView.font else { return }
    textOfNoteTextView.font = UIFont(name: font, size: textFnt.pointSize)
    textOfNoteTextView.addDoneButton(title: "Готово", target: self, selector: #selector(endEditing))
  }
  
  // MARK: - Selectors
  @objc private func addNewNote() {
    guard titleOfNoteTextView.textColor != .lightGray else { return }
    guard textOfNoteTextView.textColor != .lightGray else { return }
    let item = NoteModel()
    item.title = titleOfNoteTextView.text
    item.text = textOfNoteTextView.text
    item.fontWeight = fontWeight
    item.color = color
    item.fontSize = fontSize
    item.font = font
    delegate?.createNew(note: item)
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc private func changeSlider(sender: UISlider) {
    guard textOfNoteTextView.textColor != .lightGray else { return }
    guard sender == slider else { return }
    textOfNoteTextView.font = textOfNoteTextView.font?.withSize(CGFloat(sender.value))
    fontSize = "\(CGFloat(sender.value))"
  }
  
  @objc private func changeTextColor(sender: UIButton) {
    guard textOfNoteTextView.textColor != .lightGray else { return }
    switch sender {
    case blackButton:
      color = "black"
      textOfNoteTextView.textColor = .black
      animateButton(sender: blackButton, scaleX: 0.8, scaleY: 0.8)
    case brownButton:
      color = "brown"
      textOfNoteTextView.textColor = .brown
      animateButton(sender: brownButton, scaleX: 0.8, scaleY: 0.8)
    case greenButton:
      color = "green"
      textOfNoteTextView.textColor = .green
      animateButton(sender: greenButton, scaleX: 0.8, scaleY: 0.8)
    case whiteButton:
      color = "white"
      textOfNoteTextView.textColor = .white
      animateButton(sender: whiteButton, scaleX: 0.8, scaleY: 0.8)
    default:
      textOfNoteTextView.textColor = .black
    }
  }
  
  @objc private func changeFontWeight(sender: UIButton) {
    guard textOfNoteTextView.textColor != .lightGray else { return }
    animateButton(sender: sender, scaleX: 1, scaleY: 1)
    guard let fontWeightPoint = textOfNoteTextView.font?.pointSize else { return }
    switch sender {
    case aButton:
      fontWeight = "regular"
      switch font {
      case "Helvetica Neue" :
        textOfNoteTextView.font = UIFont(name: "Helvetica Neue", size: fontWeightPoint)
      case "Chalkboard SE" :
        textOfNoteTextView.font = UIFont(name: "Chalkboard SE", size: fontWeightPoint)
      case "Baskerville" :
        textOfNoteTextView.font = UIFont(name: "Baskerville", size: fontWeightPoint)
      default:
        textOfNoteTextView.font = UIFont(name: "HelveticaNeue", size: fontWeightPoint)
      }
    case aBigButton:
      fontWeight = "bold"
      switch font {
      case "HelveticaNeue" :
        textOfNoteTextView.font = UIFont(name: "Helvetica Neue Bold", size: fontWeightPoint)
      case "Chalkboard SE" :
        textOfNoteTextView.font = UIFont(name: "Chalkboard SE Bold", size: fontWeightPoint)
      case "Baskerville" :
        textOfNoteTextView.font = UIFont(name: "Baskerville Bold", size: fontWeightPoint)
      default:
        textOfNoteTextView.font = UIFont(name: "Helvetica Neue Bold", size: fontWeightPoint)
      }
    default:
      fontWeight = "regular"
      switch font {
      case "HelveticaNeue" :
        textOfNoteTextView.font = UIFont(name: "HelveticaNeue", size: fontWeightPoint)
      case "SF Compact" :
        textOfNoteTextView.font = UIFont(name: "SF Compact", size: fontWeightPoint)
      case "Baskerville" :
        textOfNoteTextView.font = UIFont(name: "Baskerville", size: fontWeightPoint)
      default:
        textOfNoteTextView.font = UIFont(name: "HelveticaNeue", size: fontWeightPoint)
      }
    }
  }
  
  // MARK: - Constraints
  private func setupAButtonConstraints() {
    NSLayoutConstraint.activate([
      aButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      aButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      aButton.widthAnchor.constraint(equalToConstant: 67),
      aButton.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  private func setupABigButtonConstraints() {
    NSLayoutConstraint.activate([
      aBigButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      aBigButton.leadingAnchor.constraint(equalTo: aButton.trailingAnchor, constant: -1),
      aBigButton.widthAnchor.constraint(equalToConstant: 67),
      aBigButton.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
 
  private func setupBlackButtonConstraints() {
    NSLayoutConstraint.activate([
      blackButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 10),
      blackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width / 6),
      blackButton.widthAnchor.constraint(equalToConstant: 50),
      blackButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func setupBrownButtonConstraints() {
    NSLayoutConstraint.activate([
      brownButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 10),
      brownButton.leadingAnchor.constraint(equalTo: blackButton.trailingAnchor, constant: 20),
      brownButton.widthAnchor.constraint(equalToConstant: 50),
      brownButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func setupGreenButtonConstraints() {
    NSLayoutConstraint.activate([
      greenButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 10),
      greenButton.leadingAnchor.constraint(equalTo: brownButton.trailingAnchor, constant: 20),
      greenButton.widthAnchor.constraint(equalToConstant: 50),
      greenButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func setupWhiteButtonConstraints() {
    NSLayoutConstraint.activate([
      whiteButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 10),
      whiteButton.leadingAnchor.constraint(equalTo: greenButton.trailingAnchor, constant: 20),
      whiteButton.widthAnchor.constraint(equalToConstant: 50),
      whiteButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
 
  private func setupSliderConstraints() {
    NSLayoutConstraint.activate([
      slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
      slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      slider.widthAnchor.constraint(equalToConstant: 100),
      slider.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
  
  private func setupFontTextFieldConstraints() {
    NSLayoutConstraint.activate([
      fontTextField.topAnchor.constraint(equalTo: blackButton.bottomAnchor, constant: 10),
      fontTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      fontTextField.widthAnchor.constraint(equalToConstant: 200),
      fontTextField.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
 
  private func setupTitleOfNoteTextViewConstraints() {
    NSLayoutConstraint.activate([
      titleOfNoteTextView.topAnchor.constraint(equalTo: fontTextField.bottomAnchor, constant: 10),
      titleOfNoteTextView.heightAnchor.constraint(equalToConstant: 45),
      titleOfNoteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      titleOfNoteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
    ])
  }
  
  private func setupTextOfNoteTextViewConstraints() {
    NSLayoutConstraint.activate([
      textOfNoteTextView.topAnchor.constraint(equalTo: titleOfNoteTextView.bottomAnchor, constant: 10),
      textOfNoteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
      textOfNoteTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
      textOfNoteTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
    ])
  }
}

// MARK: - UITextViewDelegate
extension NewNoteViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if textView == titleOfNoteTextView {
      let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
      let numberOfChars = newText.count
      return numberOfChars < 25
    }
    return true
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == .lightGray {
      textView.text = ""
      textView.textColor = .black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == "" {
      switch textView {
      case titleOfNoteTextView:
        textView.text = titleOfNotePlaceholder
      case textOfNoteTextView:
        textView.text = textOfNotePlaceholder
      default:
        return
      }
      textView.textColor = .lightGray
    }
  }
  
 
  func textViewDidChange(_ textView: UITextView) {
    if titleOfNoteTextView.textColor == .lightGray || textOfNoteTextView.textColor == .lightGray || titleOfNoteTextView.text.isEmpty || textOfNoteTextView.text.isEmpty {
      navigationItem.rightBarButtonItem?.isEnabled = false
    } else {
      navigationItem.rightBarButtonItem?.isEnabled = true
    }
  }
}

// MARK: - UIPickerViewDelegate
extension NewNoteViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    guard let fontSize = textOfNoteTextView.font?.pointSize else { return }
    guard textOfNoteTextView.textColor != .lightGray else { return }
    fontTextField.text = "\(fontsArray[row])"
    font = "\(fontsArray[row])"
    textOfNoteTextView.font = UIFont(name: "\(fontsArray[row])", size: fontSize)
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return fontsArray[row]
  }
}

// MARK: - UIPickerViewDataSource
extension NewNoteViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return fontsArray.count
  }
}
