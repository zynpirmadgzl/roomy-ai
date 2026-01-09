import 'package:roomy_ai/services/firebase_service.dart';
import 'package:roomy_ai/ui/views/onboarding/onboarding2_view.dart';
import 'package:roomy_ai/ui/views/profile/profile_view.dart';
import 'package:roomy_ai/ui/views/settings/settings_view.dart';
import 'package:roomy_ai/ui/views/upload_photo/uploud_photo_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../ui/views/landing/landing_view.dart';
import '../ui/views/onboarding/onboarding1_view.dart';
import '../ui/views/paywall/paywall_view.dart';
import '../ui/views/home/home_view.dart';
//flutter pub run build_runner build --delete-conflicting-outputs
@StackedApp(
  routes: [
    MaterialRoute(page: LandingView, initial: true),

    MaterialRoute(page: Onboarding1View),
    MaterialRoute(page: Onboarding2View),
    MaterialRoute(page: PaywallView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: UploadPhotoView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: SettingsView)
  ],
  dependencies: [
    
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FirebaseService)
  ],
)
class App {}