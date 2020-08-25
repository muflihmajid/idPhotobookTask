import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_arc_flutter/app/infrastructure/app_component.dart';
import 'package:clean_arc_flutter/app/misc/constants.dart';
import 'package:clean_arc_flutter/app/misc/router_argument.dart';
import 'package:clean_arc_flutter/app/ui/pages/home/controller.dart';
import 'package:clean_arc_flutter/app/ui/pages/pages.dart';
import 'package:clean_arc_flutter/app/ui/res/generated/i18n.dart';
import 'package:clean_arc_flutter/app/ui/widgets/button.dart';
import 'package:clean_arc_flutter/app/ui/widgets/loading.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends View {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState(
      AppComponent.getInjector().getDependency<HomeController>());
}

class _HomePageState extends ViewState<HomePage, HomeController>
    with WidgetsBindingObserver {
  _HomePageState(HomeController controller) : super(controller);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  int _current = 0;
  String _selectedChoices = "";
  Widget popUpMenuWidget() {
    return PopupMenuButton<String>(
      icon: Image.asset('lib/app/ui/assets/icons/filter.png',
          width: 20, height: 20),
      elevation: 8.5,
      initialValue: _selectedChoices,
      onCanceled: () {},
      onSelected: (item) => controller.onSelectedItem(item),
      itemBuilder: (BuildContext context) {
        return controller.more.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  @override
  Widget buildPage() {
    return Container(
      padding: EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Image(
              alignment: Alignment.topCenter,
              image: controller.currentUser != null
                  ? AssetImage('lib/app/ui/assets/images/Background1.png')
                  : AssetImage('lib/app/ui/assets/images/Background2.png'),
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: controller.currentUser == null
                      ? MediaQuery.of(context).size.height / 6
                      : MediaQuery.of(context).size.height / 12,
                ),
                SizedBox(
                  child: controller.currentUser == null
                      ? Column(
                          children: <Widget>[
                            Text(
                              "Hai Kamu!!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontFamily: "CentraleSansRegular",
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text("Yuk Login ",
                                style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 32,
                                    fontFamily: "CentraleSansRegular",
                                    fontWeight: FontWeight.w100),
                                textAlign: TextAlign.center),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Hai ${controller.currentUser.displayName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontFamily: "CentraleSansRegular",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _user()
                            ],
                          ),
                        ),
                ),
                Container(
                  child: CommonButton(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    height: 48,
                    buttonColor: controller.currentUser == null
                        ? AppConstants.COLOR_PRIMARY_COLOR
                        : AppConstants.COLOR_PRIMARY_BACKGROUND,
                    isDisabled: false,
                    buttonText: controller.isLoading
                        ? CommonLoading()
                        : controller.currentUser == null
                            ? S.of(context).label_enter.toUpperCase()
                            : S.of(context).label_out.toUpperCase(),
                    onPressed: () => !controller.internetAvailable
                        ? controller.showErrorFlushbar()
                        : controller.currentUser == null
                            ? controller.loginWithGoogle()
                            : controller.logoutFromGoogle(),
                  ),
                  padding: EdgeInsets.fromLTRB(
                      20,
                      controller.currentUser == null
                          ? MediaQuery.of(context).size.height * 0.06
                          : MediaQuery.of(context).size.height * 0.01,
                      20,
                      0),
                ),
                SizedBox(
                  child: _bannerSlide(),
                ),
                SizedBox(
                  height: 120,
                ),
                SizedBox(
                    child: controller.currentUser != null
                        ? Column(
                            children: generateFilesWidget(),
                          )
                        : Container()),
                controller.currentUser == null ? SizedBox() : _upload(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateFilesWidget() {
    List<Widget> listItem = List<Widget>();
    if (controller.listUpload != null) {
      for (var i = 0; i < controller.listUpload.files.length; i++) {
        listItem.add(Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.05,
              child: Text('${i + 1}'),
            ),
            Expanded(
              child: Text(controller.listUpload.files[i].name),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: FlatButton(
                child: Text(
                  'Download',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.indigo,
                onPressed: () {
                  controller.downloadGoogleDriveFile(
                      controller.listUpload.files[i].name,
                      controller.listUpload.files[i].id);
                },
              ),
            ),
          ],
        ));
      }
    }
    return listItem;
  }

  Widget _user() {
    return InkWell(
      splashColor: Colors.white,
      onTap: null,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppConstants.COLOR_PRIMARY_COLOR,
                AppConstants.COLOR_PRIMARY_BACKGROUND
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 0, 20, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            GoogleUserCircleAvatar(
              identity: controller.currentUser,
            ),
            SizedBox(height: 10),
            Text(
              controller.currentUser.displayName ?? '',
              style: TextStyle(
                color: AppConstants.COLOR_WHITE,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Text(
              controller.currentUser.email ?? '',
              style: TextStyle(
                color: AppConstants.COLOR_WHITE,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
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

  Widget _bannerSlide() {
    return Container(
      margin: EdgeInsets.only(left: 1),
      padding:
          EdgeInsets.fromLTRB(10, MediaQuery.of(context).size.width / 6, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
            child: Text(
              S.of(context).aboutus,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // here image slider
          controller.isLoading
              ? Center(child: CommonLoading())
              : CarouselSlider(
                  viewportFraction: 1.0,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: controller.iklan.isEmpty
                      ? <Widget>[Center(child: CommonLoading())]
                      : controller.map<Widget>(controller.iklan, (index, i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return new Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.99,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Image(
                                    image: AssetImage(i),
                                    fit: BoxFit.contain,
                                  ));
                            },
                          );
                        }).toList(),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.map<Widget>(
              controller.iklan,
              (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(0, 0, 0, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.4)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
