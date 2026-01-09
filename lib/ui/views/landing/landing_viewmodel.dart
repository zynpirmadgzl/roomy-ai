import 'package:roomy_ai/app/app.locator.dart';
import 'package:roomy_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';


class LandingViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Sayfa açıldığında otomatik çalışır
  void onViewModelReady() {
    _startTimer();
  }

  _startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    _navigationService.replaceWithOnboarding1View(); 
  }
}