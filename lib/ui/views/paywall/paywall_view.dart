import 'package:flutter/material.dart';
import 'package:roomy_ai/ui/common/colors.dart';
import 'package:stacked/stacked.dart';
import 'paywall_viewmodel.dart';

class PaywallView extends StackedView<PaywallViewModel> {
  const PaywallView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaywallViewModel viewModel,
    Widget? child,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;

    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      child: Scaffold(
        backgroundColor: PaywallColors.background,

        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.4,
                child: Image.asset('assets/images/img1.jpg', fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: isSmallScreen ? 4 : 8,
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: PaywallColors.white,
                                        size: isSmallScreen ? 24 : 28,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).clearSnackBars();
                                        viewModel.navigateToHome();
                                      },
                                    ),
                                  ),
                                  SizedBox(height: isSmallScreen ? 4 : 8),
                                  Text(
                                    "You're very close to your\ndream living space",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: PaywallColors.white,
                                      fontSize: isSmallScreen ? 24 : 32,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),

                            // Paket kartları
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildPackageCard(
                                    context,
                                    viewModel,
                                    isYearly: false,
                                    badgeText: "POPULAR",
                                    title: "Weekly",
                                    price: "TL199.99",
                                    subPrice: "",
                                    isSmallScreen: isSmallScreen,
                                  ),
                                  SizedBox(width: screenWidth * 0.03),
                                  _buildPackageCard(
                                    context,
                                    viewModel,
                                    isYearly: true,
                                    badgeText: "Save 81%",
                                    title: "Yearly",
                                    price: "TL1,999.99",
                                    subPrice: "Weekly TL41.67",
                                    showStars: true,
                                    isSmallScreen: isSmallScreen,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 20),

                            // Auto-renewable bilgisi
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: PaywallColors.white,
                                    size: isSmallScreen ? 16 : 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      "Auto-renewable, can be cancelled anytime.",
                                      style: TextStyle(
                                        color: PaywallColors.white,
                                        fontSize: isSmallScreen ? 11 : 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 20),

                            // Continue butonu
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: PaywallColors.primary.withOpacity(
                                        0.4,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: // PaywallView içindeki buton alanı
                                ElevatedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          "The subscription system is not active yet. Please check back later.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.black87,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFEF4433),
                                    minimumSize: const Size(
                                      double.infinity,
                                      56,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    "Continue",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Alt bilgiler
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 20,
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock,
                                        color: PaywallColors.white70,
                                        size: isSmallScreen ? 12 : 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Secured with App Store",
                                        style: TextStyle(
                                          color: PaywallColors.white70,
                                          fontSize: isSmallScreen ? 10 : 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: isSmallScreen ? 10 : 16),
                                  Wrap(
                                    spacing: 16,
                                    runSpacing: 8,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      _buildFooterLink(
                                        "Restore Purchases",
                                        isSmallScreen,
                                      ),
                                      _buildFooterLink(
                                        "Privacy Policy",
                                        isSmallScreen,
                                      ),
                                      _buildFooterLink(
                                        "Terms of Use",
                                        isSmallScreen,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context,
    PaywallViewModel viewModel, {
    required bool isYearly,
    required String badgeText,
    required String title,
    required String price,
    required String subPrice,
    bool showStars = false,
    required bool isSmallScreen,
  }) {
    bool isSelected = viewModel.isYearlySelected == isYearly;
    final cardHeight = isSmallScreen ? 200.0 : 240.0;
    final badgeTop = isSmallScreen ? -12.0 : -14.0;

    return Expanded(
      child: GestureDetector(
        onTap: () => viewModel.selectPackage(isYearly),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(
            0,
            isSelected ? (isSmallScreen ? -6 : -8) : 0,
            0,
          ),
          curve: Curves.easeOutCubic,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: cardHeight,
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 20 : 28,
                  horizontal: isSmallScreen ? 18 : 22,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            PaywallColors.primary.withOpacity(0.15),
                            PaywallColors.cardBackground,
                          ],
                        )
                      : const LinearGradient(
                          colors: [
                            PaywallColors.cardBackground,
                            PaywallColors.cardBackground,
                          ],
                        ),
                  borderRadius: BorderRadius.circular(isSmallScreen ? 24 : 28),
                  border: Border.all(
                    color: isSelected
                        ? PaywallColors.primary
                        : PaywallColors.white.withOpacity(0.15),
                    width: isSelected ? 2.5 : 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: PaywallColors.primary.withOpacity(0.3),
                            blurRadius: 24,
                            spreadRadius: 0,
                            offset: const Offset(0, 12),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showStars) ...[
                      Icon(
                        Icons.auto_awesome,
                        color: PaywallColors.primary,
                        size: isSmallScreen ? 24 : 28,
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                    ] else
                      SizedBox(height: isSmallScreen ? 32 : 40),

                    Text(
                      title,
                      style: TextStyle(
                        color: PaywallColors.white,
                        fontSize: isSmallScreen ? 20 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 12 : 16),

                    if (subPrice.isNotEmpty) ...[
                      Text(
                        subPrice,
                        style: TextStyle(
                          color: PaywallColors.white.withOpacity(0.7),
                          fontSize: isSmallScreen ? 12 : 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                    ],

                    Text(
                      price,
                      style: TextStyle(
                        color: PaywallColors.white,
                        fontSize: isSmallScreen ? 18 : 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Badge
              Positioned(
                top: badgeTop,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: PaywallColors.primary,
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 10 : 12,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: PaywallColors.primary.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: PaywallColors.white,
                        fontSize: isSmallScreen ? 10 : 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text, bool isSmallScreen) {
    return Text(
      text,
      style: TextStyle(
        color: PaywallColors.white.withOpacity(0.6),
        fontSize: isSmallScreen ? 9 : 11,
      ),
    );
  }

  @override
  PaywallViewModel viewModelBuilder(BuildContext context) => PaywallViewModel();
}
