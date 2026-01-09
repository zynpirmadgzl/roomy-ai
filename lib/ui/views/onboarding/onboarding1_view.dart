import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roomy_ai/ui/views/onboarding/onboarding1_viewmodel.dart';
import 'package:stacked/stacked.dart';

class Onboarding1View extends StackedView<Onboarding1ViewModel> {
  const Onboarding1View({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, Onboarding1ViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
        
          const ParallaxGallery(),
          Container(color: Colors.black.withOpacity(0.3)),
          Positioned(
            bottom: 40, left: 20, right: 20,
            child: Column(
              children: [
                const Text("Roomy AI A Living Space!", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                const SizedBox(height: 12),
                const Text("Discover your creativity, safety and easily turn your dreams into reality", style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity, height: 65,
                  child: ElevatedButton(
                    onPressed: viewModel.isBusy ? null : viewModel.handleStartAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: viewModel.isSuccess ? Colors.green : const Color(0xFFEF4433), // Başarı sonrası yeşil
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: viewModel.isBusy 
                      ? const CircularProgressIndicator(color: Colors.white) 
                      : Text(viewModel.isSuccess ? "Ready" : "Start", style: const TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  @override
  Onboarding1ViewModel viewModelBuilder(BuildContext context) => Onboarding1ViewModel();
}

class ParallaxGallery extends StatefulWidget {
  const ParallaxGallery({super.key});

  @override
  State<ParallaxGallery> createState() => _ParallaxGalleryState();
}

class _ParallaxGalleryState extends State<ParallaxGallery> {
  late ScrollController _ctrlLeft, _ctrlCenter, _ctrlRight;
  Timer? _timer;

  // Her şerit için özel 4 fotoğraf seti
  final List<String> _leftImages = ["img1.jpg", "img2.jpg", "img3.jpg", "img4.jpg"];
  final List<String> _centerImages = ["img5.jpg", "img6.jpg", "img7.jpg", "img8.jpg"];
  final List<String> _rightImages = ["img9.jpg", "img10.jpg", "img11.jpg", "img12.jpg"];

  @override
  void initState() {
    super.initState();
    _ctrlLeft = ScrollController(initialScrollOffset: 50);
    _ctrlCenter = ScrollController(initialScrollOffset: 400); 
    _ctrlRight = ScrollController(initialScrollOffset: 150);

    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) return;
      _scroll(_ctrlLeft, 1.0, true);   // Aşağı
      _scroll(_ctrlCenter, 0.8, false); // Yukarı (Yavaş)
      _scroll(_ctrlRight, 1.2, true);  // Aşağı (Hızlı)
    });
  }

  void _scroll(ScrollController controller, double speed, bool forward) {
    if (controller.hasClients) {
      double newOffset = forward ? controller.offset + speed : controller.offset - speed;
      
      
      if (forward && newOffset >= controller.position.maxScrollExtent) {
        newOffset = controller.position.minScrollExtent;
      } else if (!forward && newOffset <= controller.position.minScrollExtent) {
        newOffset = controller.position.maxScrollExtent;
      }
      controller.jumpTo(newOffset);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrlLeft.dispose(); _ctrlCenter.dispose(); _ctrlRight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildResponsiveColumn(_ctrlLeft, _leftImages),
        const SizedBox(width: 8),
        _buildResponsiveColumn(_ctrlCenter, _centerImages),
        const SizedBox(width: 8),
        _buildResponsiveColumn(_ctrlRight, _rightImages),
      ],
    );
  }

  Widget _buildResponsiveColumn(ScrollController controller, List<String> images) {
  return Expanded(
    child: ListView.builder(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      // Çok büyük bir sayı vererek sonsuzluk hissi yaratıyoruz ama sınır koyuyoruz
      itemCount: 10000, 
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              "assets/images/${images[index % images.length]}",
              fit: BoxFit.cover,
              // Yüksekliği sabit bir rakama çekmek (örneğin 200-250) hatayı önleyebilir
              height: MediaQuery.of(context).size.height * (index % 2 == 0 ? 0.22 : 0.28),
            ),
          ),
        );
      },
    ),
  );
}
}