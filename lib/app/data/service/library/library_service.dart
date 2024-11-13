import 'dart:ffi';

import 'package:get/get.dart';
import 'package:hoowave_memory_patch/env.dart';

class LibraryService extends GetxService {
  final Env _env = Env.instance;
  late DynamicLibrary dylib;
  final RxBool isLoaded = false.obs;

  LibraryService() {
    try {
      dylib = DynamicLibrary.open(_env.getLibName());
      isLoaded.value = true;
    } catch (e) {
      isLoaded.value = false;
    }
  }

  DynamicLibrary? getDylib(){
    if(isLoaded.value == false) return null;
    return dylib;
  }

  bool getLoadStatus(){
    return isLoaded.value;
  }
}
