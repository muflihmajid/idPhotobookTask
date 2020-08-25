import 'dart:async';
import 'dart:io';
import 'package:clean_arc_flutter/app/infrastructure/contract/base_controller.dart';
import 'package:clean_arc_flutter/app/infrastructure/di/GoogleHttpClient.dart';
import 'package:clean_arc_flutter/app/misc/user_data.dart';
import 'package:clean_arc_flutter/app/ui/res/generated/i18n.dart';
import 'package:clean_arc_flutter/app/ui/widgets/dialog.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadController extends BaseController {
  UserData _sp;
  int _border = 1;
  var drive, client;
  ga.File fileToUpload;
  GoogleSignInAccount currentUser;

  int get border => _border;
  List<File> _file = <File>[];
  List<File> get file => _file;

  UploadController(this._sp) : super() {}

  @override
  void initListeners() {
    super.initListeners();
  }

  void showDialogUpload() {
    showDialog(
        context: getContext(),
        builder: (context) => CustomDialog.confirmDialog(
            context: context,
            title: S.of(context).picker,
            content: S.of(context).pilih,
            onCancel: () {
              Navigator.pop(context);
              selectfile();
            },
            onConfirm: () {
              Navigator.pop(context);
              selectImage(ImageSource.camera);
            },
            onConfirmText: S.of(context).camera,
            onCancelText: S.of(context).file,
            onCancelTextColor: Color.fromRGBO(88, 88, 88, 1),
            onConfirmTextFontWeight: FontWeight.bold));
  }

  void showDialogDelete(int id) {
    showDialog(
        context: getContext(),
        builder: (context) => CustomDialog.confirmDialogDelete(
            context: context,
            title: S.of(context).delete,
            content: S.of(context).text_confirmation,
            onConfirm: () {
              Navigator.pop(context);
              delete(id);
            },
            onConfirmText: S.of(context).confirmation,
            onCancelText: S.of(context).rejected,
            onCancelTextColor: Color.fromRGBO(88, 88, 88, 1),
            onConfirmTextFontWeight: FontWeight.bold));
  }

  void delete(int id) {
    _file.removeAt(id);
    refreshUI();
  }

  Future selectImage(ImageSource source) async {
    var selectedImage = await ImagePicker.pickImage(source: source);
    cropImage(selectedImage);
    refreshUI();
  }


  void selectfile() async {
    List<File> _files = await FilePicker.getMultiFile();
    _file.addAll(_files);
    refreshUI();
  }

  void uploadFileToGoogleDrive() async {
    var client = GoogleHttpClient(await currentUser.authHeaders);
    var drive = ga.DriveApi(client);
    ga.File fileToUpload = ga.File();
    List<File> files = await FilePicker.getMultiFile();
    var response;
    for (int i = 0; i < files.length; i++) {
      try {
        fileToUpload
          ..name = "Uploaded_by_me" + path.basename(files[i].absolute.path);
        response = await drive.files.create(
          fileToUpload,
          supportsAllDrives: true,
          uploadMedia: ga.Media(files[i].openRead(), files[i].lengthSync()),
        );
      } catch (error) {
        print("Masuk eror ${error}");
        rethrow;
      }
    }
  }

  Future cropImage(File image) async {
//    int angka;
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 904,
        maxWidth: 904,
        cropStyle: CropStyle.rectangle,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 2),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    _file.add(croppedFile);
    // angka = _border + 1;
    // _border = angka;
    refreshUI();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
