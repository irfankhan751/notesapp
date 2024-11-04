// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../data/model/notes_model.dart';

class MainScreenSate {
  bool? isLoading = true;
  List<Note>? notesList;
  MainScreenSate({
    this.isLoading,
    this.notesList,
  });

  MainScreenSate copyWith({
    bool? isLoading,
    List<Note>? notesList,
  }) {
    return MainScreenSate(
      isLoading: isLoading ?? this.isLoading,
      notesList: notesList ?? this.notesList,
    );
  }
}
