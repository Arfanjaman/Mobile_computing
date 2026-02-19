import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class FirestoreManager: ObservableObject {
    private var db = Firestore.firestore()
    @Published var notes = [Note]()

    private func notesRef() -> CollectionReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(uid).collection("notes")
    }

    func addNote(title: String, content: String) {
        guard let ref = notesRef() else { return }
        let newNote = Note(title: title, content: content)
        do {
            _ = try ref.addDocument(from: newNote)
        } catch {
            print("Error adding document: \(error)")
        }
    }

    func getNotes() {
        guard let ref = notesRef() else {
            self.notes = []
            return
        }

        ref.order(by: "title").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting notes: \(error)")
                return
            }
            self.notes = snapshot?.documents.compactMap { doc in
                try? doc.data(as: Note.self)
            } ?? []
        }
    }

    func updateNote(note: Note) {
        guard let ref = notesRef(), let noteID = note.id else { return }
        do {
            try ref.document(noteID).setData(from: note)
        } catch {
            print("Error updating note: \(error)")
        }
    }

    func deleteNote(note: Note) {
        guard let ref = notesRef(), let noteID = note.id else { return }
        ref.document(noteID).delete { error in
            if let error = error {
                print("Error deleting note: \(error)")
            }
        }
    }
}
