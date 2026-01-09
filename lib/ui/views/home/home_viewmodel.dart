import 'package:roomy_ai/app/app.locator.dart';
import 'package:roomy_ai/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends IndexTrackingViewModel {
  final _navigationService = locator<NavigationService>();

  // Paywall'a yönlendirme
  void navigateToPaywall() => _navigationService.navigateToPaywallView();

  // Tüm kartlar için ortak veya ayrı yönlendirme tanımları
  void onDesignCardTapped(String designType) {
    // Tasarım tipine göre logic kurabiliriz
    // Şimdilik hepsi videodaki Step 1 (UploadPhotoView) sayfasına gidiyor
    _navigationService.navigateToUploadPhotoView();
  }
}