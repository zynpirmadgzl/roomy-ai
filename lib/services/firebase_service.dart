import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

Stream<List<Map<String, dynamic>>> getMyDesigns() {
  String uid = _auth.currentUser?.uid ?? "guest_user";
  
  return _firestore
      .collection('users')
      .doc(uid)
      .collection('designs')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data();
            data['id'] = doc.id; 
            return data;
          }).toList());
}
Future<User?> signInAnonymously() async {
  try {
    UserCredential userCredential = await _auth.signInAnonymously();
    return userCredential.user;
  } catch (e) {
    print("Firebase Anonim Giriş Hatası: $e");
    return null;
  }
}

  
  Future<void> saveDesign(String imageUrl, String roomType, String style) async {
    String uid = _auth.currentUser?.uid ?? "guest_user";

    await _firestore.collection('users').doc(uid).collection('designs').add({
      'imageUrl': imageUrl,
      'roomType': roomType,
      'style': style,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteDesign(String docId) async {
  String uid = _auth.currentUser?.uid ?? "guest_user";
  await _firestore
      .collection('users')
      .doc(uid)
      .collection('designs')
      .doc(docId)
      .delete();
}
}