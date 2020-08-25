import 'package:clean_arc_flutter/app/misc/user_data.dart';
import 'package:clean_arc_flutter/app/ui/pages/home/controller.dart';
import 'package:clean_arc_flutter/app/ui/pages/main/controller.dart';
import 'package:clean_arc_flutter/app/ui/pages/splash/controller.dart';
import 'package:clean_arc_flutter/app/ui/pages/upload/controller.dart';
import 'package:injector/injector.dart';

class ControllerModule {
  static void init(Injector injector) {
    injector.registerDependency<SplashController>((Injector injector) {
      return SplashController(injector.getDependency<UserData>());
    });
    injector.registerDependency<MainController>((Injector injector) {
      return MainController(injector.getDependency<UserData>());
    });
    injector.registerDependency<HomeController>((Injector injector) {
      return HomeController(injector.getDependency<UserData>());
    });

    injector.registerDependency<UploadController>((Injector injector) {
      return UploadController(injector.getDependency<UserData>());
    });
  }
  
}
