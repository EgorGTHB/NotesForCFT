import Foundation

protocol UpdateItemDelegate: AnyObject {
  
  func updateItem(note: NoteModel, index: Int)
}
