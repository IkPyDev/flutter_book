import 'package:firebase_auth/firebase_auth.dart';

class RegistrationRepository {
  static final _repository = RegistrationRepository._();
  final _firebaseAuth = FirebaseAuth.instance;

  RegistrationRepository._();

  factory RegistrationRepository.init() {
    return _repository;
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> registerUser(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }


}
