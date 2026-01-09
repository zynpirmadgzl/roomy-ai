import 'package:roomy_ai/app/app.locator.dart';
import 'package:roomy_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Onboarding1ViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  bool isSuccess = false;

  Future<void> handleStartAction() async {
    setBusy(true);
    await Future.delayed(const Duration(seconds: 2)); // Progress süresi
    setBusy(false);
    
    isSuccess = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));
    _navigationService.navigateToOnboarding2View(); // 2. Onboarding'e geç
  }
}