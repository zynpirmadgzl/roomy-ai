import 'package:roomy_ai/app/app.locator.dart';
import 'package:roomy_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Onboarding2ViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void navigateToPaywall() {
    _navigationService.navigateToPaywallView(); // Paywall'a geç
  }
}