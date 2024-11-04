// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:notesapp/data/model/notes_model.dart';

class DetailNoteSate {
  bool? isLoading = false;
  Note note;
  DetailNoteSate({
    this.isLoading,
    required this.note,
  });

  DetailNoteSate copyWith({
    bool? isLoading,
    Note? note,
  }) {
    return DetailNoteSate(
      isLoading: isLoading ?? this.isLoading,
      note: note ?? this.note,
    );
  }
}
