import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as DIO;
import 'package:fgi_y2j/Api/api_route.dart';
import 'package:fgi_y2j/features/Dialog/Authentication_Message.dart';
import 'package:fgi_y2j/features/authentication/controller/AuthenticationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/options/cancel.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ProfileController extends GetxController{
  final profileEditFormKey=GlobalKey<FormState>();
  final cardEditFormKey=GlobalKey<FormState>();
  RxnString pickImagePath=RxnString();

  ///controller
  final oldCardNumberController=TextEditingController();
  final newCardNumberController=TextEditingController();

  pickImage({
    ImageSource imageSource = ImageSource.gallery,required BuildContext context
  }) async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      cropImage(pickedImage.path,context);
    }
  }

  cropImage(String filePath, BuildContext context) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
      cropStyle: CropStyle.circle,
      uiSettings: [],
    );
    if (croppedImage != null) {
    pickImagePath.value = croppedImage.path;
    uploadImage(File(pickImagePath.value!),context);


    }
  }

  Future<void> uploadImage(File file, context ) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(
      msgFontSize:14 ,
      msgTextAlign: TextAlign.left,
      barrierDismissible: true,
      valuePosition: ValuePosition.center,
      max: 100,
      msg: 'Image Uploading...',
      progressBgColor: Colors.transparent,

      cancel: Cancel(
        cancelClicked: () {
          pd.close();
        },
      ),
    );
    String fileName = file.path.split('/').last;
    DIO.FormData formData = DIO.FormData.fromMap({
      "file":
      await DIO.MultipartFile.fromFile(file.path, filename:fileName),
    });
    pd.update(value: 50,msg: 'Image Uploading...');
    DIO.Response response = await DIO.Dio().post("$BASE_URL/upload", data: formData);
    log("Response: ${response.data}");
    Map<String, dynamic> messageRes = response.data;
    AuthenticationController authenticationController=Get.put(AuthenticationController());
    Map<String, dynamic> map = {
      "profilePicture":messageRes["fileUrl"],
      "email": "${authenticationController.userModel.value!.email}"
    };
    authenticationController.userUpdate(map, context).then((value){
      pd.close();
      if(value){
        pd.close();
        showSuccessDialogInTop("Information", "User Profile Image Upload Successful", context);
      }
    });
  }
}