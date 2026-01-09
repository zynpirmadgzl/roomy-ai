import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class PaywallViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  bool _isYearlySelected = true; // Varsayılan olarak yıllık seçili
  bool get isYearlySelected => _isYearlySelected;

  void selectPackage(bool isYearly) {
    _isYearlySelected = isYearly;
    notifyListeners();
  }

  void navigateToHome() {
    _navigationService.replaceWithHomeView(); 
  }
}