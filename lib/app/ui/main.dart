import 'package:clean_arc_flutter/app/infrastructure/app_component.dart';
import 'package:clean_arc_flutter/app/infrastructure/router.dart';
import 'package:clean_arc_flutter/app/ui/pages/splash/view.dart';
import 'package:clean_arc_flutter/app/ui/res/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


main() {
  DotEnv().load('.env'); // load env
  AppComponent.init(); // init dependency
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp()); // run app
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Router _router = Router();
  static bool isConnectedToInternet = false;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale('id'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}

