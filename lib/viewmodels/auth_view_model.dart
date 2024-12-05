import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? currentUser;

  Future<void> signInWithGoogle() async {
    try {
      // Realiza o login com o Google
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth == null) return;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        // Preenche o modelo com os dados do usuário, incluindo photoURL
        currentUser = UserModel(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoURL: user.photoURL, // Adiciona o photoURL
        );

        // Salva ou atualiza os dados no Firestore
        await _firestore.collection('users').doc(user.uid).set(
              currentUser!.toMap(),
              SetOptions(merge: true), // Atualiza se já existir
            );

        notifyListeners(); // Notifica alterações para a UI
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during Google Sign-In: $e");
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    currentUser = null;
    notifyListeners(); // Notifica alterações para a UI
  }
}
