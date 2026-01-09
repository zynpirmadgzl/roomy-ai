import 'package:roomy_ai/app/app.locator.dart';
import 'package:roomy_ai/services/firebase_service.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  final _firebaseService = locator<FirebaseService>();

  String _userId = "Loading...";
  String get userId => _userId;
Future<void> init() async {
  setBusy(true);
  try {

    final user = await _firebaseService.signInAnonymously();
    if (user != null) {
      _userId = user.uid;
    } else {
      _userId = "Auth Failed";
    }
  } catch (e) {
   
    _userId = "Connection Error";
    print("LOG: Firebase Hatası -> $e");
  } finally {
    setBusy(false);
    notifyListeners();
  }
}

  void onChangeUsername() {
    print("Change Username tıklandı");
  }

  void onLanguageSelect() {
    print("Language Selection tıklandı");
  }

  void onLogout() async {
    
    //await _firebaseService.signOut();
    notifyListeners();
  }
}