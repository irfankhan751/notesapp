import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/data/model/notes_model.dart';
import 'package:notesapp/presentation/screens/new_note/controller/new_note_state.dart';

class NewNoteCubit extends Cubit<NewNoteSate> {
  NewNoteCubit() : super(NewNoteSate());

  Future<bool> createNote(String title, String description) async {
    try {
      emit(state.copyWith(isLoading: true));

      String tempId = FirebaseFirestore.instance.collection('notes').doc().id;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User is not logged in");
      }

      final String noteId = FirebaseFirestore.instance
          .collection('usernotes')
          .doc(user.uid)
          .collection('notes')
          .doc()
          .id;
      final note = Note(
          id: noteId,
          title: title,
          description: description,
          createdBy: user.uid,
          createdAt: DateTime.now());
      await FirebaseFirestore.instance
          .collection('usernotes')
          .doc(user.uid)
          .collection('notes')
          .doc(noteId)
          .set(note.toMap());

      emit(state.copyWith(isLoading: false));
      return true;
    } catch (e) {
      emit(state.copyWith(isLoading: false));

      return false;
    }
  }
}
