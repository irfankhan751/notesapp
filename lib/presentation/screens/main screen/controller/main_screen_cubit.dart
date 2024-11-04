import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/data/model/notes_model.dart';
import 'package:notesapp/presentation/screens/main%20screen/controller/main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenSate> {
  MainScreenCubit() : super(MainScreenSate());

  Stream<List<Note>> fetchUserNotes() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User is not logged in");

    var list = FirebaseFirestore.instance
        .collection('usernotes')
        .doc(user.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList());

    return list;
  }

  void deleteNote(Note note) {
    deleteNoteFromFirestore(note.id);
  }

  Future<void> deleteNoteFromFirestore(String noteId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User is not logged in");
      }

      var note = await FirebaseFirestore.instance
          .collection('usernotes')
          .doc(user.uid)
          .collection('notes')
          .doc(noteId)
          .get();

      note.reference.delete();
    } catch (e) {
      print("Failed to delete note: $e");
    }
  }
}
