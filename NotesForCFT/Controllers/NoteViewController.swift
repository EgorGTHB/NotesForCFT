import UIKit
import Hero

final class NoteViewController: UIViewController {
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
  private let titleOfNotePlaceholder = "Введите заголовок (до 25 символов)"
  private let textOfNotePlaceholder = "Введите текст"
  private let fontsArray = ["Helvetica Neue", "Chalkboard SE", "Baskerville"]
  private var fontWeight = "regular"
  private var color = ".black"
  private var fontSize = "18"
  private var font = "Helvetica Neue"
  private var editRightBarButton = UIBarButtonItem()
  private var hideRightBarButton = UIBarButtonItem()
  private var choiceEditOrHide = true
  private let item = NoteModel()
  private let spareOptionItem = NoteModel()
  private lazy var aHeightConstr = aButton.heightAnchor.constraint(equalToConstant: 0)
  private lazy var aBigHeightConstr = aBigButton.heightAnchor.constraint(equalToConstant: 0)
  private lazy var sliderHeightConstr = slider.heightAnchor.constraint(equalToConstant: 0)
  private lazy var blackBtnHeightConstr = blackButton.heightAnchor.constraint(equalToConstant: 0)
  private lazy var brownBtnHeightConstr = brownButton.heightAnchor.constraint(equalToConstant: 0)
  private lazy var greenBtnHeightConstr = greenButton.heightAnchor.constraint(equalToConstant: 0)
  private lazy var whiteBtnHeightConstr = whiteButton.heightAnchor.constraint(equalToConstant: 0)
  private lazy var fontTxtFldHeightConstr = fontTextField.heightAnchor.constraint(equalToConstant: 0)
  private lazy var sliderTopConstr = slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
  private lazy var blackBtnTopConstr = blackButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 0)
  private lazy var brownBtnTopConstr = brownButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 0)
  private lazy var greenBtnTopConstr = greenButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 0)
  private lazy var whiteBtnTopConstr = whiteButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 0)
  private lazy var fontTxtFldTopConstr = fontTextField.topAnchor.constraint(equalTo: blackButton.bottomAnchor, constant: 0)
  private lazy var ttlOfNtTopTextViewConstr = titleOfNoteTextView.topAnchor.constraint(equalTo: fontTextField.bottomAnchor, constant: 0)
  
  // MARK: - Public Properties
  weak var delegate: UpdateItemDelegate?
  var index = Int()
  
  //MARK: - UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    if titleOfNoteTextView.textColor != .lightGray || textOfNoteTextView.textColor != .lightGray || textOfNoteTextView.text.isEmpty || textOfNoteTextView.text.isEmpty {
      saveNote()
    }
    if textOfNoteTextView.text.isEmpty || titleOfNoteTextView.textColor == .lightGray {
      titleOfNoteTextView.text = spareOptionItem.title
      saveNote()
      
    }
    if textOfNoteTextView.text.isEmpty  || textOfNoteTextView.textColor == .lightGray {
      textOfNoteTextView.text = spareOptionItem.text
      saveNote()
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    blackButton.layer.cornerRadius = blackButton.frame.width / 2
    brownButton.layer.cornerRadius = brownButton.frame.width / 2
    greenButton.layer.cornerRadius = greenButton.frame.width / 2
    whiteButton.layer.cornerRadius = whiteButton.frame.width / 2
  }
  
  // MARK: - Visual Components
  private func setupNavigationController() {
    editRightBarButton = UIBarButtonItem(title: "Изменить", style: .done, target: self, action: #selector(editOrHide))
    hideRightBarButton = UIBarButtonItem(title: "Скрыть", style: .done, target: self, action: #selector(editOrHide))
    navigationItem.rightBarButtonItem = editRightBarButton
    navigationItem.title = "Заметка"
  }
  
  // MARK: - Private Methods
  private func setupView() {
    setupNavigationController()
    addSubviews()
    setupAButton()
    setupABigButton()
    setupBlackButton()
    setupBrownButton()
    setupGreenButton()
    setupWhiteButton()
    setupSlider()
    setupFontTextField()
    setupFontPicker()
    setupTitleOfNoteTextView()
    setupTextOfNoteTextView()
    addTarget()
    setupSelfView()
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
    [aButton, aBigButton, slider, blackButton, brownButton, greenButton, whiteButton, fontTextField, titleOfNoteTextView, textOfNoteTextView].forEach {
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
    aButton.isHidden = true
    shadow(aButton)
  }
  
  private func setupABigButton() {
    aBigButton.layer.borderWidth = 1
    aBigButton.layer.borderColor = UIColor.black.cgColor
    aBigButton.setTitle("A", for: .normal)
    aBigButton.tintColor = .black
    aBigButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    aBigButton.isHidden = true
    shadow(aBigButton)
  }
  
  private func setupBlackButton() {
    blackButton.backgroundColor = .black
    blackButton.clipsToBounds = true
    blackButton.isHidden = true
    shadow(blackButton)
  }
  
  private func setupBrownButton() {
    brownButton.backgroundColor = .brown
    brownButton.clipsToBounds = true
    brownButton.isHidden = true
    shadow(brownButton)
  }
  
  private func setupGreenButton() {
    greenButton.backgroundColor = .green
    greenButton.clipsToBounds = true
    greenButton.isHidden = true
    shadow(greenButton)
  }
  
  private func setupWhiteButton() {
    whiteButton.backgroundColor = .white
    whiteButton.clipsToBounds = true
    whiteButton.isHidden = true
    shadow(whiteButton)
  }
  
  private func setupSlider() {
    let configuration = UIImage.SymbolConfiguration(pointSize: 15, weight: .medium)
    let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
    slider.minimumValue = Float(17)
    slider.maximumValue = Float(23)
    slider.tintColor = .black
    slider.isHidden = true
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
    fontTextField.isHidden = true
    shadow(fontTextField)
  }
  
  private func setupFontPicker() {
    fontPicker.delegate = self
    fontPicker.dataSource = self
  }
  
  private func setupTitleOfNoteTextView() {
    titleOfNoteTextView.delegate = self
    titleOfNoteTextView.autocorrectionType = .no
    titleOfNoteTextView.font = .systemFont(ofSize: 18, weight: .bold)
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
    textOfNoteTextView.heroID = "heroEdit"
    textOfNoteTextView.autocorrectionType = .no
    textOfNoteTextView.layer.cornerRadius = 15
    textOfNoteTextView.backgroundColor = .init(red: 240/255, green: 181/255, blue: 13/255, alpha: 1)
    textOfNoteTextView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
    textOfNoteTextView.layer.masksToBounds = true
    textOfNoteTextView.addDoneButton(title: "Готово", target: self, selector: #selector(endEditing))
  }
  
  private func changedConstraints(rightBarButtonItem: UIBarButtonItem, aBut: Bool, aBigBut: Bool, sldr: Bool, blackBut: Bool, brownBut: Bool, greenBut: Bool, whiteBut: Bool, fontTextFld: Bool, fontPckr: Bool, aHeight: CGFloat, aBigHeight: CGFloat, sliderHeight: CGFloat, blackBtnHeight: CGFloat, brownBtnHeight: CGFloat, greenBtnHeight: CGFloat, whiteBtnHeight: CGFloat, fontTxtFldHeight: CGFloat, sldrTopConstr: CGFloat, blackBtnTop: CGFloat, brownBtnTop: CGFloat, greenBtnTop: CGFloat,  whiteBtnTop: CGFloat, fontTxtFldTop: CGFloat,  ttlOfNtTop: CGFloat) {
    navigationItem.rightBarButtonItem = rightBarButtonItem
    choiceEditOrHide.toggle()
    aButton.isHidden = aBut
    aBigButton.isHidden = aBigBut
    slider.isHidden = sldr
    blackButton.isHidden = blackBut
    brownButton.isHidden = brownBut
    greenButton.isHidden = greenBut
    whiteButton.isHidden = whiteBut
    fontTextField.isHidden = fontTextFld
    fontPicker.isHidden = fontPckr
    view.layoutIfNeeded()
    UIView.animate(withDuration: 0.1) {
      self.aHeightConstr.constant = aHeight
      self.aBigHeightConstr.constant =  aBigHeight
      self.sliderHeightConstr.constant = sliderHeight
      self.blackBtnHeightConstr.constant = blackBtnHeight
      self.brownBtnHeightConstr.constant = brownBtnHeight
      self.greenBtnHeightConstr.constant = greenBtnHeight
      self.whiteBtnHeightConstr.constant = whiteBtnHeight
      self.fontTxtFldHeightConstr.constant = fontTxtFldHeight
      self.sliderTopConstr.constant = sldrTopConstr
      self.blackBtnTopConstr.constant = blackBtnTop
      self.brownBtnTopConstr.constant = brownBtnTop
      self.greenBtnTopConstr.constant = greenBtnTop
      self.whiteBtnTopConstr.constant = whiteBtnTop
      self.fontTxtFldTopConstr.constant = fontTxtFldTop
      self.ttlOfNtTopTextViewConstr.constant = ttlOfNtTop
      self.view.layoutIfNeeded()
    }
  }
  
  // MARK: - Public methods
  func configureNote(_ model: NoteModel) {
    spareOptionItem.title = model.title
    spareOptionItem.text = model.text
    guard let doubleFontSize = Double(model.fontSize) else { return }
    titleOfNoteTextView.text = model.title
    textOfNoteTextView.text = model.text
    textOfNoteTextView.font = UIFont(name: model.font, size: CGFloat(doubleFontSize))
    switch model.fontWeight {
    case "regular":
      switch model.font {
      case "Helvetica Neue" :
        textOfNoteTextView.font = UIFont(name: "Helvetica Neue", size: CGFloat(doubleFontSize))
      case "Chalkboard SE" :
        textOfNoteTextView.font = UIFont(name: "Chalkboard SE", size: CGFloat(doubleFontSize))
      case "Baskerville" :
        textOfNoteTextView.font = UIFont(name: "Baskerville", size: CGFloat(doubleFontSize))
      default:
        textOfNoteTextView.font = UIFont(name: "HelveticaNeue", size: CGFloat(doubleFontSize))
      }
    case "bold":
      switch model.font {
      case "HelveticaNeue" :
        textOfNoteTextView.font = UIFont(name: "Helvetica Neue Bold", size: CGFloat(doubleFontSize))
      case "Chalkboard SE" :
        textOfNoteTextView.font = UIFont(name: "Chalkboard SE Bold", size: CGFloat(doubleFontSize))
      case "Baskerville" :
        textOfNoteTextView.font = UIFont(name: "Baskerville Bold", size: CGFloat(doubleFontSize))
      default:
        textOfNoteTextView.font = UIFont(name: "Helvetica Neue Bold", size: CGFloat(doubleFontSize))
      }
    default:
      switch model.font {
      case "HelveticaNeue" :
        textOfNoteTextView.font = UIFont(name: "HelveticaNeue", size: CGFloat(doubleFontSize))
      case "SF Compact" :
        textOfNoteTextView.font = UIFont(name: "SF Compact", size: CGFloat(doubleFontSize))
      case "Baskerville" :
        textOfNoteTextView.font = UIFont(name: "Baskerville", size: CGFloat(doubleFontSize))
      default:
        textOfNoteTextView.font = UIFont(name: "HelveticaNeue", size: CGFloat(doubleFontSize))
      }
    }
    switch model.color {
    case "green":
      textOfNoteTextView.textColor = .green
    case "brown":
      textOfNoteTextView.textColor = .brown
    case "black":
      textOfNoteTextView.textColor = .black
    case "white":
      textOfNoteTextView.textColor = .white
    default:
      textOfNoteTextView.textColor = .black
    }
  }
  
  // MARK: - Selectors
  private func saveNote() {
    if let text = titleOfNoteTextView.text, !text.isEmpty, !textOfNoteTextView.text.isEmpty {
      item.title = titleOfNoteTextView.text
      item.text = textOfNoteTextView.text
      item.fontWeight = fontWeight
      item.color = color
      item.fontSize = fontSize
      item.font = font
      delegate?.updateItem(note: item, index: index)
    }
  }
  
  @objc private func changeSlider(sender: UISlider) {
    guard sender == slider else { return }
    textOfNoteTextView.font = textOfNoteTextView.font?.withSize(CGFloat(sender.value))
    fontSize = "\(CGFloat(sender.value))"
  }
  
  @objc private func changeTextColor(sender: UIButton) {
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
  
  @objc func editOrHide() {
    if choiceEditOrHide {
      self.changedConstraints(rightBarButtonItem: hideRightBarButton, aBut: false, aBigBut: false, sldr: false, blackBut: false, brownBut: false, greenBut: false, whiteBut: false, fontTextFld: false, fontPckr: false, aHeight: 30, aBigHeight: 30, sliderHeight: 50, blackBtnHeight: 50, brownBtnHeight: 50, greenBtnHeight: 50, whiteBtnHeight: 50, fontTxtFldHeight: 30, sldrTopConstr: 90, blackBtnTop: 10, brownBtnTop: 10, greenBtnTop: 10, whiteBtnTop: 10, fontTxtFldTop: 10, ttlOfNtTop: 10)
    }
    else {
      self.changedConstraints(rightBarButtonItem: editRightBarButton, aBut: true, aBigBut: true, sldr: true, blackBut: true, brownBut: true, greenBut: true, whiteBut: true, fontTextFld: true, fontPckr: true, aHeight: 0, aBigHeight: 0, sliderHeight: 0, blackBtnHeight: 0, brownBtnHeight: 0, greenBtnHeight: 0, whiteBtnHeight: 0, fontTxtFldHeight: 0, sldrTopConstr: 0, blackBtnTop: 0, brownBtnTop: 0, greenBtnTop: 0, whiteBtnTop: 0, fontTxtFldTop: 0, ttlOfNtTop: 0)
      saveNote()
      resignFirstResponder()
    }
  }
  
  // MARK: - Constraints
  private func setupAButtonConstraints() {
    NSLayoutConstraint.activate([
      aButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      aButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      aButton.widthAnchor.constraint(equalToConstant: 67),
      aHeightConstr
    ])
  }
  
  private func setupABigButtonConstraints() {
    NSLayoutConstraint.activate([
      aBigButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      aBigButton.leadingAnchor.constraint(equalTo: aButton.trailingAnchor, constant: -1),
      aBigButton.widthAnchor.constraint(equalToConstant: 67),
      aBigHeightConstr
    ])
  }
  
  private func setupBlackButtonConstraints() {
    NSLayoutConstraint.activate([
      blackBtnTopConstr,
      blackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width / 6),
      blackButton.widthAnchor.constraint(equalToConstant: 50),
      blackBtnHeightConstr
    ])
  }
  
  private func setupBrownButtonConstraints() {
    NSLayoutConstraint.activate([
      brownBtnTopConstr,
      brownButton.leadingAnchor.constraint(equalTo: blackButton.trailingAnchor, constant: 20),
      brownButton.widthAnchor.constraint(equalToConstant: 50),
      brownBtnHeightConstr
    ])
  }
  
  private func setupGreenButtonConstraints() {
    NSLayoutConstraint.activate([
      greenBtnTopConstr,
      greenButton.leadingAnchor.constraint(equalTo: brownButton.trailingAnchor, constant: 20),
      greenButton.widthAnchor.constraint(equalToConstant: 50),
      greenBtnHeightConstr
    ])
  }
  
  private func setupWhiteButtonConstraints() {
    NSLayoutConstraint.activate([
      whiteBtnTopConstr,
      whiteButton.leadingAnchor.constraint(equalTo: greenButton.trailingAnchor, constant: 20),
      whiteButton.widthAnchor.constraint(equalToConstant: 50),
      whiteBtnHeightConstr
    ])
  }
  
  private func setupSliderConstraints() {
    NSLayoutConstraint.activate([
      sliderTopConstr,
      slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      slider.widthAnchor.constraint(equalToConstant: 100),
      sliderHeightConstr
    ])
  }
  
  private func setupFontTextFieldConstraints() {
    NSLayoutConstraint.activate([
      fontTxtFldTopConstr,
      fontTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      fontTextField.widthAnchor.constraint(equalToConstant: 200),
      fontTxtFldHeightConstr
    ])
  }
  
  private func setupTitleOfNoteTextViewConstraints() {
    NSLayoutConstraint.activate([
      ttlOfNtTopTextViewConstr,
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
extension NoteViewController: UITextViewDelegate {
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if let character = text.first, character.isNewline {
      textView.resignFirstResponder()
      return false
    }
    
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
}

// MARK: - UIPickerViewDelegate
extension NoteViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    guard let fontSize = textOfNoteTextView.font?.pointSize else { return }
    fontTextField.text = "\(fontsArray[row])"
    font = "\(fontsArray[row])"
    textOfNoteTextView.font = UIFont(name: "\(fontsArray[row])", size: fontSize)
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return fontsArray[row]
  }
}

// MARK: - UIPickerViewDataSource
extension NoteViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return fontsArray.count
  }
}

