import UIKit

final class NoteCell: UICollectionViewCell {
  // MARK: - Private Properties
  private let titleOfNoteLabel = UILabel()
  private let textOfNoteLabel = UILabel()
  private let deleteButton = UIButton(type: .system)
  
  // MARK: - Public Properties
   var delegate: DeleteItemDelegate?
   var index: IndexPath?

  // MARK: - UITableViewCell
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCell()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    self.layer.cornerRadius = 15.0
    self.layer.borderWidth = 5.0
    self.layer.borderColor = UIColor.clear.cgColor
    self.layer.masksToBounds = true
    self.contentView.layer.cornerRadius = 15.0
    self.contentView.layer.borderWidth = 5.0
    self.contentView.layer.borderColor = UIColor.clear.cgColor
    self.contentView.layer.masksToBounds = true    
    self.layer.shadowColor = UIColor.black.cgColor;
    self.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
    self.layer.shadowOpacity = 0.8
    self.layer.shadowRadius = 3
    self.layer.masksToBounds = false
  }
  
  //MARK: - Visual Components
  private func setupAppearance() {
    backgroundColor = .init(red: 240/255, green: 181/255, blue: 13/255, alpha: 1)
  }
  
  //MARK: - Private Methods
  private func setupCell() {
    setupAppearance()
    addSubviews()
    setupTitleOfNoteLabel()
    setupTextOfNoteLabel()
    setupDeleteButton()
    setupTitleOfNoteLabelConstraints()
    setupTextOfNoteLabelConstraints()
    setupDeleteButtonConstraints()
  }
  
  private func addSubviews() {
    [titleOfNoteLabel, textOfNoteLabel, deleteButton].forEach {
      contentView.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setupTitleOfNoteLabel() {
    titleOfNoteLabel.textAlignment = .center
    titleOfNoteLabel.textColor = .black
    titleOfNoteLabel.font = .systemFont(ofSize: 18, weight: .bold)
  }
  
  private func setupTextOfNoteLabel() {
    textOfNoteLabel.textAlignment = .center
    textOfNoteLabel.textColor = .black
    textOfNoteLabel.font = .systemFont(ofSize: 18, weight: .regular)
  }
  
  private func setupDeleteButton() {
    deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
    deleteButton.tintColor = .red
    deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
  }
  
  @objc private func deleteButtonPressed() {
    guard let indx = index?.row else { return }
    deleteButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   usingSpringWithDamping: CGFloat(0.20),
                   initialSpringVelocity: CGFloat(6.0),
                   options: UIView.AnimationOptions.allowUserInteraction,
                   animations: { [unowned self] in
      self.deleteButton.transform = CGAffineTransform.identity
    }, completion: { [weak self] _ in
      self?.delegate?.deleteItem(index: indx)
    })
  }
  
  // MARK: - Public methods
  func configureCell(model: NoteModel) {
    guard let doubleFontSize = Double(model.fontSize) else { return }
    titleOfNoteLabel.text = model.title
    textOfNoteLabel.text = model.text
    textOfNoteLabel.font = UIFont(name: model.font, size: doubleFontSize)
    switch model.fontWeight {
    case "regular":
      switch model.font {
      case "Helvetica Neue" :
        textOfNoteLabel.font = UIFont(name: "Helvetica Neue", size: doubleFontSize)
      case "Chalkboard SE" :
        textOfNoteLabel.font = UIFont(name: "Chalkboard SE", size: doubleFontSize)
      case "Baskerville" :
        textOfNoteLabel.font = UIFont(name: "Baskerville", size: doubleFontSize)
      default:
        textOfNoteLabel.font = UIFont(name: "HelveticaNeue", size: doubleFontSize)
      }
    case "bold":
      switch model.font {
      case "HelveticaNeue" :
        textOfNoteLabel.font = UIFont(name: "Helvetica Neue Bold", size: doubleFontSize)
      case "Chalkboard SE" :
        textOfNoteLabel.font = UIFont(name: "Chalkboard SE Bold", size: doubleFontSize)
      case "Baskerville" :
        textOfNoteLabel.font = UIFont(name: "Baskerville Bold", size: doubleFontSize)
      default:
        textOfNoteLabel.font = UIFont(name: "Helvetica Neue Bold", size: doubleFontSize)
      }
    default:
      switch model.font {
      case "HelveticaNeue" :
        textOfNoteLabel.font = UIFont(name: "HelveticaNeue", size: doubleFontSize)
      case "SF Compact" :
        textOfNoteLabel.font = UIFont(name: "SF Compact", size: doubleFontSize)
      case "Baskerville" :
        textOfNoteLabel.font = UIFont(name: "Baskerville", size: doubleFontSize)
      default:
        textOfNoteLabel.font = UIFont(name: "HelveticaNeue", size: doubleFontSize)
      }
    }
    switch model.color {
    case "green":
      textOfNoteLabel.textColor = .green
    case "brown":
      textOfNoteLabel.textColor = .brown
    case "black":
      textOfNoteLabel.textColor = .black
    case "white":
      textOfNoteLabel.textColor = .white
    default:
      textOfNoteLabel.textColor = .black
    }
  }
  
  //MARK: - Constraints
  private func setupTitleOfNoteLabelConstraints() {
    NSLayoutConstraint.activate([
      titleOfNoteLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleOfNoteLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
      titleOfNoteLabel.widthAnchor.constraint(equalToConstant: 300),
      titleOfNoteLabel.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
  
  private func setupTextOfNoteLabelConstraints() {
    NSLayoutConstraint.activate([
      textOfNoteLabel.topAnchor.constraint(equalTo: titleOfNoteLabel.bottomAnchor, constant: 10),
      textOfNoteLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      textOfNoteLabel.widthAnchor.constraint(equalToConstant: 300),
      textOfNoteLabel.heightAnchor.constraint(equalToConstant: 25)
    ])
  }
  
  private func setupDeleteButtonConstraints() {
    NSLayoutConstraint.activate([
      deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
      deleteButton.widthAnchor.constraint(equalToConstant: 30),
      deleteButton.heightAnchor.constraint(equalToConstant: 30)
    ])
  }
}
