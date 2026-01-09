import 'package:flutter/material.dart';
import 'package:roomy_ai/ui/common/colors.dart';
import 'package:roomy_ai/ui/common/subscribe_button.dart';
import 'package:stacked/stacked.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    // Stream'den gelen tasarımlar listesi
    final designs = viewModel.data ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false, // Metnin sola yaslanması için
        title: const Text(
          "Roomy AI",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SubscribeButton(onPressed: viewModel.navigateToPaywall),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black, size: 28),
            onPressed: viewModel.navigateToSettingsView,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Designs",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                // Eğer tasarım varsa Select/Delete butonu görünsün
                if (designs.isNotEmpty)
                  ElevatedButton(
                    onPressed: viewModel.isEditMode 
                        ? viewModel.deleteSelectedDesigns 
                        : viewModel.toggleEditMode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: viewModel.isEditMode
                          ? Colors.red // Silme modunda kırmızı
                          : PaywallColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      viewModel.isEditMode ? "Delete" : "Select",
                      style: TextStyle(
                        color: viewModel.isEditMode ? Colors.white : Colors.black
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: viewModel.isBusy 
                  ? const Center(child: CircularProgressIndicator()) 
                  : designs.isEmpty
                      ? _buildEmptyState()
                      : _buildDesignGrid(viewModel, designs),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.architecture, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text(
            "No Designs Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "You haven't created any designs yet. Go to the home page to create your first design.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesignGrid(ProfileViewModel viewModel, List<Map<String, dynamic>> designs) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.8,
      ),
      itemCount: designs.length,
      itemBuilder: (context, index) {
        final design = designs[index];
        final String docId = design['id'] ?? ''; // FirebaseService'den gelen döküman ID'si
        final String imageUrl = design['imageUrl'] ?? '';
        final String roomType = design['roomType'] ?? 'Room';
        final isSelected = viewModel.selectedItems.contains(docId);

        return GestureDetector(
          onTap: () {
            if (viewModel.isEditMode) {
              viewModel.toggleSelection(docId);
            } else {
              // Tasarım detayına gitme logic'i eklenebilir
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    // Resim yüklenirken placeholder
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade100,
                        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      );
                    },
                  ),
                ),
              ),
              // Düzenleme modunda Checkbox ikonu
              if (viewModel.isEditMode)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Icon(
                    isSelected
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isSelected ? Colors.red : Colors.white,
                    size: 28,
                  ),
                ),
              // Sol üstte kategori etiketi
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    roomType,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();
}