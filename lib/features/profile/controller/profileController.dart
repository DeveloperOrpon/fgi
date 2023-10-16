import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{
  final profileEditFormKey=GlobalKey<FormState>();
  RxnString pickImagePath=RxnString();

  pickImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      cropImage(pickedImage.path);
    }
  }

  cropImage(String filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      cropStyle: CropStyle.circle,
      uiSettings: [],
    );
    if (croppedImage != null) {
    pickImagePath.value = croppedImage.path;
    }
  }
}