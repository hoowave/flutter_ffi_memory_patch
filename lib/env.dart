import 'dart:ffi' as ffi;

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:win32/win32.dart';

import 'app/routes/app_pages.dart';
import 'app_binding.dart';

enum BuildType { windows, mac }

class Env {
  static Env? _instance;

  static get instance => _instance;

  static bool get isWindows => _instance!._buildType == BuildType.windows;

  static bool get isMac => _instance!._buildType == BuildType.mac;

  static Size get appSize => const Size(400, 600);

  late BuildType _buildType;

  Env(BuildType buildType) {
    _buildType = buildType;
  }

  factory Env.newInstance(BuildType buildType) {
    _instance ??= Env(buildType);
    return _instance!;
  }

  String getLibName(){
    return "hoowave_memory_patch.dll";
  }

  Future<void> setWindow() async{
    WidgetsFlutterBinding.ensureInitialized();
    await DesktopWindow.setWindowSize(Env.appSize);
    await DesktopWindow.setMinWindowSize(Env.appSize);
    await DesktopWindow.setMaxWindowSize(Env.appSize);
    final className = TEXT('FLUTTER_RUNNER_WIN32_WINDOW');
    await Future.delayed(const Duration(milliseconds: 100));
    final hwnd = FindWindow(className, ffi.nullptr);
    if (hwnd != 0) {
      final style = GetWindowLongPtr(hwnd, WINDOW_LONG_PTR_INDEX.GWL_STYLE);
      SetWindowLongPtr(hwnd, WINDOW_LONG_PTR_INDEX.GWL_STYLE, style & ~WINDOW_STYLE.WS_SIZEBOX & ~WINDOW_STYLE.WS_MAXIMIZEBOX);
    }
  }

  void run() async{
    if(Env.isWindows) await setWindow();
    runApp(const Init());
  }
}

class Init extends StatelessWidget {
  const Init({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Hoowave Memory Editor",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      themeMode: ThemeMode.light,
      theme: ThemeData.light(),
      initialBinding: AppBinding(),
    );
  }

}
