import 'package:roomy_ai/app/app.locator.dart'; // Locator'ın yerini kontrol et
import 'package:roomy_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:roomy_ai/services/firebase_service.dart'; // Kendi dosya yolunu yaz

class ProfileViewModel extends StreamViewModel<List<Map<String, dynamic>>> {
  final _navigationService = locator<NavigationService>();
  final _firebaseService = locator<FirebaseService>();

  // Firebase'den gelen akışı dinle
  @override
  Stream<List<Map<String, dynamic>>> get stream => _firebaseService.getMyDesigns();

  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  // Silinecek dökümanların ID'lerini tutar
  List<String> selectedItems = [];

  void toggleEditMode() {
    _isEditMode = !_isEditMode;
    selectedItems.clear(); 
    notifyListeners();
  }

  void toggleSelection(String designId) {
    if (selectedItems.contains(designId)) {
      selectedItems.remove(designId);
    } else {
      selectedItems.add(designId);
    }
    notifyListeners();
  }

  void navigateToPaywall() {
    _navigationService.navigateToPaywallView();
  }

  void navigateToSettingsView() {
    _navigationService.navigateToSettingsView();
  }

  // Firebase üzerinden toplu silme işlemi
  Future<void> deleteSelectedDesigns() async {
    setBusy(true); // Silme işlemi sırasında loading gösterebilirsin
    for (String id in selectedItems) {
      await _firebaseService.deleteDesign(id);
    }
    _isEditMode = false;
    selectedItems.clear();
    setBusy(false);
    notifyListeners();
  }
}