import 'package:image_picker/image_picker.dart';

Future<XFile?> selectImage() async {
  final ImagePicker picker = ImagePicker();

  final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);

  return selectedImage;
}

Future<XFile?> takeImage() async {
  final ImagePicker picker = ImagePicker();

  final XFile? selectedImage = await picker.pickImage(source: ImageSource.camera);

  return selectedImage;
}
