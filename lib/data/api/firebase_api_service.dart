import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  static const NOTES_COLLECTION = "notes";
  CollectionReference getFirebaseNotesCollection() {
    return FirebaseFirestore.instance.collection("notes");
  }

  DocumentReference getNotesReference(String uid) {
    return FirebaseFirestore.instance.collection(NOTES_COLLECTION).doc(uid);
  }
}
