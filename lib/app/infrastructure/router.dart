import 'package:clean_arc_flutter/app/ui/pages/main/view.dart';
import 'package:clean_arc_flutter/app/ui/pages/pages.dart';
import 'package:clean_arc_flutter/app/ui/pages/upload/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router {
  RouteObserver<PageRoute> routeObserver;

  Router() {
    routeObserver = RouteObserver<PageRoute>();
  }

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.main:
        return _buildRoute(settings, new MainPage());
      case Pages.upload:
        return _buildRoute(
            settings,
            new UploadPage(
              arguments: settings.arguments,
            ));
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
