import 'dart:convert';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/data/model/current_process_model.dart';
import 'package:hoowave_memory_patch/app/data/service/library/library_service.dart';

import '../../model/process_model.dart';

typedef OpenProcessFunc = ffi.Int32 Function(ffi.Int32);
typedef OpenProcess = int Function(int);

typedef CloseProcessFunc = ffi.Int32 Function(ffi.Int32);
typedef CloseProcess = int Function(int);

typedef GetApplicationListFunc = ffi.Void Function(ffi.Pointer<ffi.Void>, ffi.Int32);
typedef GetApplicationList = void Function(ffi.Pointer<ffi.Void>, int);

typedef GetProcessListFunc = ffi.Void Function(ffi.Pointer<ffi.Void> buffer, ffi.Int32 bufferSize);
typedef GetProcessList = void Function(ffi.Pointer<ffi.Void> buffer, int bufferSize);


class ProcessService extends GetxService {
  final LibraryService libraryService;
  late ffi.DynamicLibrary dylib;
  late OpenProcess openProcess;
  late CloseProcess closeProcess;
  // late GetProcessList getProcessList;
  late GetApplicationList getApplicationList;

  int? currentProcessHandle;

  ProcessService(this.libraryService) {
    if(libraryService.isLoaded.value == false) return;
    dylib = libraryService.getDylib()!;
    openProcess = dylib
        .lookup<ffi.NativeFunction<OpenProcessFunc>>("openProcess")
        .asFunction();

    closeProcess = dylib
        .lookup<ffi.NativeFunction<CloseProcessFunc>>("closeProcess")
        .asFunction();

    getApplicationList = dylib
        .lookupFunction<GetApplicationListFunc, GetApplicationList>('getApplicationList');

    // getProcessList = dylib
    //     .lookup<NativeFunction<GetProcessListFunc>>("getProcessList")
    //     .asFunction();
  }

  // void fetchProcessList() {
  //   const int bufferSize = 20000;
  //   final Pointer<Uint8> buffer = calloc<Uint8>(bufferSize);
  //
  //   getProcessList(buffer.cast<Void>(), bufferSize);
  //
  //   final resultString = buffer.cast<Utf8>().toDartString();
  //   print('Process List: $resultString');
  // }

  List<ProcessModel> fetchApplicationList(){
    final bufferSize = 4096;
    final buffer = calloc<ffi.Uint8>(bufferSize);

    try {
      getApplicationList(buffer.cast(), bufferSize);

      final jsonString = buffer.cast<Utf8>().toDartString();
      final List<dynamic> jsonData = jsonDecode(jsonString);
      final processList = jsonData.map((item) => ProcessModel.fromJson(item)).toList();
      return processList;
    } finally {
      calloc.free(buffer);
    }
  }

  CurrentProcessModel openTargetProcess(ProcessModel processModel) {
    final processHandle = openProcess(processModel.pid);
    return CurrentProcessModel(processHandle: processHandle, name: processModel.name);
  }

  void closeTargetProcess() {
    if (currentProcessHandle != null) {
      closeProcess(currentProcessHandle!);
      currentProcessHandle = null;
    }
  }

}
