import Foundation
import RealmSwift

class NoteModel: Object {
  @objc dynamic var title: String = ""
  @objc dynamic var text: String = ""
  @objc dynamic var fontWeight: String = ""
  @objc dynamic var color: String = ""
  @objc dynamic var fontSize: String = ""
  @objc dynamic var font: String = ""
}
