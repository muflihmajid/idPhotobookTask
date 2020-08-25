
import 'package:clean_arc_flutter/app/infrastructure/app_component.dart';
import 'package:clean_arc_flutter/app/ui/pages/home/view.dart';
import 'package:clean_arc_flutter/app/ui/pages/main/controller.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';

class MainPage extends View {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState(
      AppComponent.getInjector().getDependency<MainController>());
}

class _MainPageState extends ViewState<MainPage, MainController>
    with WidgetsBindingObserver {
  _MainPageState(MainController controller) : super(controller);

  List<Widget> pages = [
    new HomePage(),
  ];

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

  @override
Widget buildPage() {
    return new Scaffold(
      key: globalKey,
      body: pages[0],
    );
  }
}
