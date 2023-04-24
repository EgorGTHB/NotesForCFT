import Foundation

protocol CreateNoteDelegate: AnyObject {
  
  func createNew(note: NoteModel)
}
