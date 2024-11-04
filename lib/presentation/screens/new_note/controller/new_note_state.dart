// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewNoteSate {
  bool? isLoading = false;
  NewNoteSate({
    this.isLoading,
  });

  NewNoteSate copyWith({
    bool? isLoading,
  }) {
    return NewNoteSate(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
