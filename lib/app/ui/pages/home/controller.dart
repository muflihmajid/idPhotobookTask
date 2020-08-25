import 'dart:async';
import 'dart:io';

import 'package:clean_arc_flutter/app/infrastructure/contract/base_controller.dart';
import 'package:clean_arc_flutter/app/infrastructure/di/GoogleHttpClient.dart';
import 'package:clean_arc_flutter/app/misc/constants.dart';
import 'package:clean_arc_flutter/app/misc/router_argument.dart';
import 'package:clean_arc_flutter/app/misc/user_data.dart';
import 'package:clean_arc_flutter/app/ui/pages/pages.dart';
import 'package:clean_arc_flutter/app/ui/res/generated/i18n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:path/path.dart' as path;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';

class HomeController extends BaseController {
  UserData _sp;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    'https://www.googleapis.com/auth/drive.appdata',
    'https://www.googleapis.com/auth/drive',
    'https://www.googleapis.com/auth/drive.file'
  ]);

  List<String> _iklan = <String>[
    'lib/app/ui/assets/images/iklan1.png',
    'lib/app/ui/assets/images/iklan2.png',
    'lib/app/ui/assets/images/iklan3.png'
  ];
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _signedIn = false;
  GoogleSignInAccount _currentUser;

  ga.FileList _list;
  List<String> _more = ['Edit', 'Delete'];
  ga.FileList get listUpload => _list;
  List<String> get more => _more;
  List<String> get iklan => _iklan;
  bool get signedIn => _signedIn;

  GoogleSignInAccount get currentUser => _currentUser;

  UserData get sp => _sp;

  HomeController(this._sp) : super() {
    // setupFlushbar();
  }

  @override
  void initListeners() {
    super.initListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInternetConnected() {
    super.onInternetConnected();
    // kFlushbar..show(getContext());
  }

  void onSelectedItem(String item) {
    showLoading();
    // reset
  }

  void upload() {
    Navigator.pushNamed(getContext(), Pages.upload,
        arguments: RouteArgumentsUpload(currentUser: currentUser));
  }

  Future<void> loginWithGoogle() async {
    googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount googleSignInAccount) async {
      if (googleSignInAccount != null) {
        _currentUser = googleSignInAccount;
        _afterGoogleLogin(googleSignInAccount);
        refreshUI();
      }
    });
    if (signedIn) {
      try {
        googleSignIn.signInSilently().whenComplete(() => () {});
        refreshUI();
      } catch (e) {
        _signedIn = false;
        refreshUI();
      }
    } else {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      _afterGoogleLogin(googleSignInAccount);
      refreshUI();
    }
  }

  Future<void> _afterGoogleLogin(GoogleSignInAccount gSA) async {
    _currentUser = gSA;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await _currentUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');
    _signedIn = true;
    _listGoogleDriveFiles();
    refreshUI();
  }

  void logoutFromGoogle() async {
    var _duration = new Duration(seconds: 4);
    Timer(_duration, () {
      googleSignIn.signOut().then((value) {
        print("User Sign Out");
        _signedIn = false;
        _currentUser = null;
        refreshUI();
      });
    });
  }

  Future<void> downloadGoogleDriveFile(String fName, String gdID) async {
    var client = GoogleHttpClient(await _currentUser.authHeaders);
    var drive = ga.DriveApi(client);
    ga.Media file = await drive.files
        .get(gdID, downloadOptions: ga.DownloadOptions.FullMedia);
    print(file.stream);

    final directory = await getExternalStorageDirectory();
    print(directory.path);
    final saveFile = File(
        '${directory.path}/${new DateTime.now().millisecondsSinceEpoch}$fName');
    List<int> dataStore = [];
    file.stream.listen((data) {
      print("DataReceived: ${data.length}");
      dataStore.insertAll(dataStore.length, data);
    }, onDone: () {
      print("Task Done");
      saveFile.writeAsBytes(dataStore);
      print("File saved at ${saveFile.path}");
    }, onError: (error) {
      print("Some Error");
    });
  }

  void uploadFileToGoogleDrive() async {
    var client = GoogleHttpClient(await _currentUser.authHeaders);
    var drive = ga.DriveApi(client);
    ga.File fileToUpload = ga.File();
    List<File> files = await FilePicker.getMultiFile();
    // var file = await FilePicker.getFile();
    //fileToUpload..parents = ["1JVu_lSQNMVjJDABN4elpAKIDdhlGFVMO"];
    //fileToUpload..name = path.basename(file.absolute.path);
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

    print(response.toJson());
    _listGoogleDriveFiles();
  }

  Future<void> _listGoogleDriveFiles() async {
    var client = GoogleHttpClient(await _currentUser.authHeaders);
    var drive = ga.DriveApi(client);
    drive.files.list(q: "name contains 'Uploaded_by_me'").then((value) {
      _list = value;
      for (var i = 0; i < _list.files.length; i++) {
        print("Id: ${_list.files[i].id} File Name:${_list.files[i].name}");
      }
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void onInternetDisconnected() {
    super.onInternetDisconnected();
  }

  Widget showErrorFlushbar() {
    return Flushbar(
      message: S.of(getContext()).no_connection,
      icon: Icon(
        Icons.info_outline,
        size: 30,
        color: Colors.white,
      ),
      backgroundColor: AppConstants.COLOR_PRIMARY_COLOR,
      duration: Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
    )..show(getContext());
  }
}
