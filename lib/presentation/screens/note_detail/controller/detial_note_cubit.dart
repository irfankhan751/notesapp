import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/data/model/notes_model.dart';
import 'package:notesapp/presentation/screens/edit%20note/controller/edit_note_state.dart';
import 'package:notesapp/presentation/screens/note_detail/controller/detail_note_state.dart';

class DetailNoteCubit extends Cubit<DetailNoteSate> {
  DetailNoteCubit(Note note) : super(DetailNoteSate(note: note)) {}
}
