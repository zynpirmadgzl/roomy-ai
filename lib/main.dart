import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roomy_ai/app/app.router.dart';
import 'package:roomy_ai/firebase_options.dart';
import 'app/app.locator.dart'; 
import 'package:stacked_services/stacked_services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   setupLocator(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Roomy AI',
      // Rotaları Stacked'a emanet ediyoruz:
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}