import UIKit
import Hero
import RealmSwift

final class AllNotesViewController: UIViewController {
  // MARK: - Private Properties
  private let notesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  private let layout = UICollectionViewFlowLayout()
  private var models: Results<NoteModel>!
  private var arrIndexPath = [IndexPath]()
  private let realm = try! Realm()
  private var startNote = NoteModel()

  //MARK: - UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .white
    appearance.shadowColor = .clear
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  //MARK: - Visual Components
  private func setupNavigationController() {
    navigationItem.title = "Заметки"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
    navigationController?.hero.isEnabled = true
  }
  
  // MARK: - Private Methods
  private func setupView() {
    setupNavigationController()
    addSubviews()
    setupSelfView()
    setupNotesCollectionView()
    setupPostsTableViewConstraints()
  }
  
  private func addSubviews() {
    [notesCollectionView].forEach {
      view.addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setupSelfView() {
    view.backgroundColor = .white
    models = realm.objects(NoteModel.self)
    if models.count == 0 {
      startNote.title = "Ваша первая заметка!"
      startNote.text = "Попробуйте создать свою первую заметку или просто измените эту :) Вы также можете выбрать шрифт, цвет и другое, щелкнув на крестик в правом верхнем углу на начальном экране"
      startNote.fontWeight = "regular"
      startNote.color = "black"
      startNote.fontSize = "18"
      startNote.font = "Helvetica Neue"
      createNew(note: startNote)
    }
  }
  
  private func setupNotesCollectionView() {
    layout.scrollDirection = UICollectionView.ScrollDirection.vertical
    layout.minimumLineSpacing = 10
    notesCollectionView.setCollectionViewLayout(layout, animated: true)
    notesCollectionView.delegate = self
    notesCollectionView.dataSource = self
    notesCollectionView.backgroundColor = UIColor.clear
    notesCollectionView.register(NoteCell.self, forCellWithReuseIdentifier: "noteCell")
    notesCollectionView.showsVerticalScrollIndicator = false
  }
  
  // MARK: - Constraints
  private func setupPostsTableViewConstraints() {
    NSLayoutConstraint.activate([
      notesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      notesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      notesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      notesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  // MARK: - Selectors
  @objc func addNewNote() {
    let newViewController = NewNoteViewController()
    newViewController.navigationItem.largeTitleDisplayMode = .never
    newViewController.delegate = self
    newViewController.isHeroEnabled = true
    navigationController?.heroNavigationAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
    navigationController?.pushViewController(newViewController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource
extension AllNotesViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if models?.count != 0 {
      return models.count
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let noteCell = collectionView.dequeueReusableCell(withReuseIdentifier: "noteCell", for: indexPath) as? NoteCell else { return UICollectionViewCell() }
    noteCell.index = indexPath
    noteCell.delegate = self
    noteCell.configureCell(model: models[indexPath.row])
    return noteCell
  }
}

// MARK: - UICollectionViewFlowLayout
extension AllNotesViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 4.5)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
  }
}

// MARK: - UITableViewDelegate
extension AllNotesViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if arrIndexPath.contains(indexPath) == false {
      cell.alpha = 0
      let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 200, 0)
      cell.layer.transform = transform
      UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        cell.alpha = 1
        cell.layer.transform = CATransform3DIdentity
      })
      arrIndexPath.append(indexPath)
      self.notesCollectionView.reloadData()
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let noteViewController = NoteViewController()
    let model = models[indexPath.row]
    let cell = collectionView.cellForItem(at: indexPath) as? NoteCell
    noteViewController.delegate = self
    noteViewController.index = indexPath.row
    noteViewController.configureNote(model)
    noteViewController.navigationItem.largeTitleDisplayMode = .never
    noteViewController.isHeroEnabled = true
    cell?.heroID = "heroEdit"
    navigationController?.heroNavigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
    navigationController?.pushViewController(noteViewController, animated: true)
  }
}

// MARK: - CreateNoteDelegate
extension AllNotesViewController: CreateNoteDelegate {
  
  func createNew(note: NoteModel) {
    try! realm.write {
      realm.add(note)
      DispatchQueue.main.async { [unowned self] in
        self.notesCollectionView.reloadData()
      }
    }
  }
}

// MARK: - DeleteItemProtocol
extension AllNotesViewController: DeleteItemDelegate {
  
  func deleteItem(index: Int) {
    let deleteObj = models[index]
    try! realm.write {
      realm.delete(deleteObj)
      DispatchQueue.main.async { [unowned self] in
        self.notesCollectionView.reloadData()
      }
    }
  }
}

extension AllNotesViewController: UpdateItemDelegate {
  
  func updateItem(note: NoteModel, index: Int) {
    let item = realm.objects(NoteModel.self)[index]
    try! realm.write {
      item.font = note.font
      item.title = note.title
      item.fontSize = note.fontSize
      item.fontWeight = note.fontWeight
      item.color = note.color
      item.text = note.text
    }
    DispatchQueue.main.async { [unowned self] in
      self.notesCollectionView.reloadData()
    }
  }
}
