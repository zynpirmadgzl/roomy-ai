import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dotted_border/dotted_border.dart';
import 'upload_photo_viewmodel.dart';

class UploadPhotoView extends StackedView<UploadPhotoViewModel> {
  const UploadPhotoView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, UploadPhotoViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: _buildStepHeader(context),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Upload Photo", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  color: Colors.grey.shade400,
                  strokeWidth: 2,
                  dashPattern: const [8, 4],
                  radius: const Radius.circular(24),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: viewModel.hasImage
                      ? _buildImagePreviewUI(context, viewModel)
                      : _buildUploadPlaceholderUI(context, viewModel),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (viewModel.hasImage)
              _buildContinueBtn(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- RESİM ÖNİZLEME (DOSYA VEYA ASSET) ---
  Widget _buildImagePreviewUI(BuildContext context, UploadPhotoViewModel viewModel) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: viewModel.selectedImageFile != null
                ? Image.file(viewModel.selectedImageFile!, fit: BoxFit.cover)
                : Image.asset(viewModel.selectedAssetPath!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Row(
            children: [
              _actionIconButton(Icons.close, const Color(0xFFFB0F04), Colors.white, viewModel.removeImage),
              const SizedBox(width: 12),
              _actionIconButton(Icons.edit, Colors.white, Colors.black, () => _showPickerSheet(context, viewModel)),
            ],
          ),
        ),
      ],
    );
  }

  // --- ÖRNEK FOTOLAR DAHİL BOTTOM SHEET ---
  void _showPickerSheet(BuildContext context, UploadPhotoViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text("Add Empty Room Photo", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _pickerItem(Icons.photo_library_outlined, "Photos", () { Navigator.pop(context); viewModel.pickImage(false); }),
                  _pickerItem(Icons.camera_alt_outlined, "Camera", () { Navigator.pop(context); viewModel.pickImage(true); }),
                ]),
                const SizedBox(height: 40),
                const Align(alignment: Alignment.centerLeft, child: Text("Example Photos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      viewModel.selectExampleImage(index);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/img${index + 1}.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- YARDIMCI WIDGETLAR ---
  Widget _buildStepHeader(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const SizedBox(width: 48),
        const Text("Step 1 / 4", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        IconButton(icon: const Icon(Icons.close, color: Colors.black, size: 28), onPressed: () => Navigator.pop(context)),
      ]),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(4, (index) => Container(
        width: 65, height: 4, margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(color: index == 0 ? Colors.black : Colors.grey.shade300, borderRadius: BorderRadius.circular(2)),
      ))),
    ]);
  }

  Widget _actionIconButton(IconData icon, Color bg, Color iconColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }

  Widget _buildUploadPlaceholderUI(BuildContext context, UploadPhotoViewModel viewModel) {
    return GestureDetector(
      onTap: () => _showPickerSheet(context, viewModel),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Start Designing", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text("Design Your Dream Living Space", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(color: const Color(0xFFFB0F04), borderRadius: BorderRadius.circular(30)),
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text("Select Photo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            Icon(Icons.add_circle, color: Colors.white, size: 20),
          ]),
        ),
      ]),
    );
  }

  Widget _buildContinueBtn() => SizedBox(
    width: double.infinity, height: 60,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFB0F04), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 0),
      child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
    ),
  );

  Widget _pickerItem(IconData icon, String label, VoidCallback onTap) => InkWell(onTap: onTap, child: Column(children: [
    Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: Icon(icon, size: 30, color: Colors.black87)),
    const SizedBox(height: 8), Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
  ]));

  @override
  UploadPhotoViewModel viewModelBuilder(BuildContext context) => UploadPhotoViewModel();
}