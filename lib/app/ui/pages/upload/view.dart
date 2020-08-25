import 'package:clean_arc_flutter/app/infrastructure/app_component.dart';
import 'package:clean_arc_flutter/app/misc/router_argument.dart';
import 'package:clean_arc_flutter/app/misc/user_data.dart';
import 'package:clean_arc_flutter/app/ui/pages/Upload/controller.dart';
import 'package:clean_arc_flutter/app/ui/res/generated/i18n.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class UploadPage extends View {
  final RouteArgumentsUpload arguments;
  UploadPage({Key key, this.arguments}) : super(key: key);

  @override
  _UploadPageState createState() => new _UploadPageState(
      UploadController(AppComponent.getInjector().getDependency<UserData>()),
      arguments);
}

class _UploadPageState extends ViewState<UploadPage, UploadController> {
  _UploadPageState(UploadController controller, RouteArgumentsUpload arguments)
      : super(controller) {
    controller.currentUser = arguments.currentUser;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget buildPage() {
    //double scaleWidth = MediaQuery.of(context).size.width / 360;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).upload,
          style: TextStyle(
              fontFamily: "MMCOFFICE-Regular", fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      key: globalKey,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  "Upload file anda",
                  style: TextStyle(
                      fontFamily: "MMCOFFICE-Regular",
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 30),
                Column(
                  children: _border(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _border() {
    List<Widget> listItem = List<Widget>();
    if (controller.file.isEmpty) {
      for (var i = 0; i < controller.border; i++) {
        listItem.add(
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              width: 320,
              height: 90,
              child: DottedBorder(
                color: Colors.black,
                dashPattern: [10, 8],
                child: Container(
                  color: Colors.white,
                  child: controller.file.isEmpty || controller.file[i] == null
                      ? Center(
                          child: Column(
                            children: <Widget>[
                              Spacer(),
                              IconButton(
                                color: Colors.grey,
                                icon: Icon(Icons.add_a_photo),
                                onPressed: () {
                                  controller.showDialogUpload();
                                },
                              ),
                              Text(
                                "Tap Here to Add File",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : Center(child: Image.file(controller.file[i])),
                ),
              ),
            ),
          ),
        );
      }
    } else {
      for (var i = 0; i < controller.file.length; i++) {
        print("Data lis border dapet lengeth $i");
        listItem.add(
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              width: 320,
              height: 490,
              child: DottedBorder(
                color: Colors.black,
                dashPattern: [10, 8],
                child: Container(
                  color: Colors.white,
                  child: controller.file.isEmpty || controller.file[i] == null
                      ? Center(
                          child: Column(
                            children: <Widget>[
                              Spacer(),
                              IconButton(
                                color: Colors.grey,
                                icon: Icon(Icons.add_a_photo),
                                onPressed: () {
                                  controller.showDialogUpload();
                                },
                              ),
                              Text(
                                "Tap Here to Add Photo",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            AspectRatio(
                                aspectRatio: 1 / 2,
                                child: Image.file(controller.file[i])),
                            IconButton(
                              color: Colors.grey,
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                controller.showDialogDelete(i);
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
      }
      listItem.add(
        Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          width: 290,
          height: 90,
          child: DottedBorder(
            color: Colors.black,
            dashPattern: [10, 8],
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () {
                        controller.showDialogUpload();
                      },
                    ),
                    Text(
                      "Tap Here to Add Photo",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listItem;
  }

   Widget _upload() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              S.of(context).backup,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.upload();
              //controller.uploadFileToGoogleDrive();
            },
            child: Container(
              margin: EdgeInsets.only(top: 50),
              width: 380,
              height: 80,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff471a91), Color(0xff3cabff)],
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "THIS MONTH",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'CentraleSansRegular'),
                  ),
                  Text(
                    "\$32.20",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'CentraleSansRegular'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
