import 'package:flutter/material.dart';
import 'package:roomy_ai/ui/common/animated_design_card.dart';
import 'package:roomy_ai/ui/common/colors.dart';
import 'package:roomy_ai/ui/common/subscribe_button.dart';
import 'package:roomy_ai/ui/views/profile/profile_view.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';
// AnimatedDesignCard'ı ayrı bir dosyada tutuyorsan buraya import etmelisin.

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: viewModel.currentIndex == 0
          ? AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: false,
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text(
        "Roomy AI",
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(width: 10),
      SubscribeButton(
        onPressed: viewModel.navigateToPaywall,
      ),
    ],
  ),
)

          : null,

      body: _getViewForIndex(viewModel.currentIndex, viewModel),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: viewModel.currentIndex,
        onTap: viewModel.setIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  PaywallColors.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // Sekmelere göre içerik döndüren fonksiyon
  Widget _getViewForIndex(int index, HomeViewModel viewModel) {
    switch (index) {
      case 0:
        return _buildHomeContent(viewModel);
      case 1:
        return const Center(child: Text("Explore / Discover Page"));
      case 2:
        return ProfileView();
      default:
        return _buildHomeContent(viewModel);
    }
  }

  // Ana Sayfa İçeriği (4 Dinamik Kart ve Banner)
  Widget _buildHomeContent(HomeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 1. Roomy Banana Pro Banner
          _buildBanner(),
          const SizedBox(height: 24),

          // 2. Tasarım Kartları (Dinamik Resimlerle 4 Seçenek)
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.72,
            children: [
              AnimatedDesignCard(
                title: "Empty Room Design",
                description: "Redesign your empty room.",
                tag: "Popular",
                tagColor: PaywallColors.primary,
                beforeImagePath: 'assets/images/img1.jpg',
                afterImagePath: 'assets/images/img2.jpg',
                onTap: () => viewModel.onDesignCardTapped("empty"),
              ),
              AnimatedDesignCard(
                title: "Open Area Design",
                description: "Redesign your garden and open area.",
                tag: "Recommended",
                tagColor: PaywallColors.primary,
                beforeImagePath: 'assets/images/img2.jpg',
                afterImagePath: 'assets/images/img3.jpg',
                onTap: () => viewModel.onDesignCardTapped("open"),
              ),
              AnimatedDesignCard(
                title: "Decoration Design",
                description: "Redesign your decoration and room.",
                tag: "Popular",
                tagColor: PaywallColors.primary,
                beforeImagePath: 'assets/images/img5.jpg',
                afterImagePath: 'assets/images/img6.jpg',
                onTap: () => viewModel.onDesignCardTapped("decoration"),
              ),
              AnimatedDesignCard(
                title: "Outdoor Design",
                description: "Redesign your outdoor space.",
                tag: "New",
                tagColor: PaywallColors.primary,
                beforeImagePath: 'assets/images/img7.jpg',
                afterImagePath: 'assets/images/img8.jpg',
                onTap: () => viewModel.onDesignCardTapped("outdoor"),
              ),
            ],
          ),
          const SizedBox(height: 80), // Alt menü için boşluk
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/banner.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay (yazılar daha okunaklı olsun diye)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),

          // New & Popular tag
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: PaywallColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "New and Popular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Title + description
          Positioned(
            left: 16,
            bottom: 20,
            right: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Roomy Banana Pro",
                  style: TextStyle(
                    color: PaywallColors.secondary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Go beyond standards. Design your living space with Roomy Banana Pro’s privileged features.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),

          // Try button
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: const StadiumBorder(),
              ),
              child: const Row(
                children: [
                  Text("Try", style: TextStyle(color: Colors.white)),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
