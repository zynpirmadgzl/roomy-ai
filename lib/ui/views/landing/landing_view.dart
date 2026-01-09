import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'landing_viewmodel.dart';

class LandingView extends StackedView<LandingViewModel> {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, LandingViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/landing.png', // Sadece bu fotoğraf görünecek
          width: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  LandingViewModel viewModelBuilder(BuildContext context) => LandingViewModel();

  @override
void onViewModelReady(LandingViewModel viewModel) {
  viewModel.onViewModelReady();
  super.onViewModelReady(viewModel);
}
}