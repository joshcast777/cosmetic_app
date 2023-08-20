import 'package:image_picker/image_picker.dart';

/// Selecciona una imagen de la Galería
Future<XFile?> selectImage() async {
  final ImagePicker picker = ImagePicker();

  final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);

  return selectedImage;
}

/// Selecciona una imagen de la cámara
Future<XFile?> takeImage() async {
  final ImagePicker picker = ImagePicker();

  final XFile? selectedImage = await picker.pickImage(source: ImageSource.camera);

  return selectedImage;
}
