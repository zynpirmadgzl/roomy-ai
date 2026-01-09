import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class UploadPhotoViewModel extends BaseViewModel {
  File? _selectedImageFile; 
  String? _selectedAssetPath; 

  File? get selectedImageFile => _selectedImageFile;
  String? get selectedAssetPath => _selectedAssetPath;
  bool _isRoomSelectionMode = false;
bool get isRoomSelectionMode => _isRoomSelectionMode;

 
  bool get hasImage => _selectedImageFile != null || _selectedAssetPath != null;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(bool fromCamera) async {
    final XFile? image = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      _selectedAssetPath = null;
      _selectedImageFile = File(image.path);
      notifyListeners();
    }
  }

  void selectExampleImage(int index) {
    _selectedImageFile = null; 
    _selectedAssetPath = 'assets/images/img${index + 1}.jpg';
    notifyListeners();
  }

  void removeImage() {
    _selectedImageFile = null;
    _selectedAssetPath = null;
    notifyListeners();
  }
}