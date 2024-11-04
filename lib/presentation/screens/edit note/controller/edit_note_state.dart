// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:notesapp/data/model/notes_model.dart';

class EditNoteSate {
  bool? isLoading = false;
  Note note;
  EditNoteSate({
    this.isLoading,
    required this.note,
  });

  EditNoteSate copyWith({
    bool? isLoading,
    Note? note,
  }) {
    return EditNoteSate(
      isLoading: isLoading ?? this.isLoading,
      note: note ?? this.note,
    );
  }
}
