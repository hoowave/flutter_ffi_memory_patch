import 'package:get/get.dart';


import '../modules/memory/bindings/memory_binding.dart';
import '../modules/memory/views/memory_view.dart';
import '../modules/process/bindings/process_binding.dart';
import '../modules/process/views/process_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROCESS,
      page: () => const ProcessView(),
      binding: ProcessBinding(),
    ),
    GetPage(
      name: _Paths.MEMORY,
      page: () => const MemoryView(),
      binding: MemoryBinding(),
    ),
  ];
}
