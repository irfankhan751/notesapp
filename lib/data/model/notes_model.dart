// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String description;
  String createdBy;
  DateTime? createdAt;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt!) // createdAt
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        createdBy: map['createdBy'] ?? '',
        createdAt: ((map['createdAt'] as Timestamp?)?.toDate()));
  }
}
