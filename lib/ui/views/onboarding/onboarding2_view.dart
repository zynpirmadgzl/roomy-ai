import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'onboarding2_viewmodel.dart';

class Onboarding2View extends StackedView<Onboarding2ViewModel> {
  const Onboarding2View({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, Onboarding2ViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text("Transform Empty Spaces\ninto Magnificent Places", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildStaticItem("Interior Design", "assets/interior.png"), // Statik fotolar
                    _buildStaticItem("Garden Design", "assets/garden.png"),
                    _buildStaticItem("Balcony Design", "assets/balcony.png"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: viewModel.navigateToPaywall,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(double.infinity, 60), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaticItem(String title, String asset) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(asset, height: 180, width: double.infinity, fit: BoxFit.cover),
              const CircleAvatar(backgroundColor: Colors.white, radius: 10), // Tasarımdaki beyaz nokta
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Onboarding2ViewModel viewModelBuilder(BuildContext context) => Onboarding2ViewModel();
}