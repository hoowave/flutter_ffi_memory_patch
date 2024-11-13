import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:get/get.dart';
import 'package:hoowave_memory_patch/app/data/service/library/library_service.dart';

typedef ReadProcessMemoryFunc = Int32 Function(
    Int32, Pointer<Void>, Pointer<Void>, Int32);
typedef WriteProcessMemoryFunc = Int32 Function(
    Int32, Pointer<Void>, Pointer<Void>, Int32);
typedef ReadProcessMemory = int Function(
    int, Pointer<Void>, Pointer<Void>, int);
typedef WriteProcessMemory = int Function(
    int, Pointer<Void>, Pointer<Void>, int);

class MemoryService extends GetxService {
  final LibraryService libraryService;
  late DynamicLibrary dylib;
  late ReadProcessMemory readProcessMemory;
  late WriteProcessMemory writeProcessMemory;

  MemoryService(this.libraryService) {
    if(libraryService.isLoaded.value == false) return;
    dylib = libraryService.getDylib()!;
    readProcessMemory = dylib
        .lookup<NativeFunction<ReadProcessMemoryFunc>>("readProcessMemory")
        .asFunction();
    writeProcessMemory = dylib
        .lookup<NativeFunction<WriteProcessMemoryFunc>>("writeProcessMemory")
        .asFunction();
  }

  int readMemory(int processHandle, int address, int size) {
    final buffer = malloc<Uint8>(size);
    if (readProcessMemory(
            processHandle, Pointer.fromAddress(address), buffer.cast(), size) !=
        0) {
      final data = buffer.asTypedList(size);
      int result = 0;
      if (data.length == 1) {
        result = data[0];
      } else if (data.length == 2) {
        result = data[0] | (data[1] << 8);
      } else if (data.length == 4) {
        result = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
      }
      // print(result);
      malloc.free(buffer);
      return result;
    } else {
      malloc.free(buffer);
      return -1;
    }
  }

  bool writeMemory(int processHandle, int address, int data) {
    final List<int> byteArray = [
      data & 0xFF,
      (data >> 8) & 0xFF,
      (data >> 16) & 0xFF,
      (data >> 24) & 0xFF
    ];
    print(byteArray);
    final buffer = malloc<Uint8>(byteArray.length);
    final typedBuffer = buffer.asTypedList(byteArray.length);
    typedBuffer.setAll(0, byteArray);

    final result = writeProcessMemory(processHandle,
        Pointer.fromAddress(address), buffer.cast(), byteArray.length);
    malloc.free(buffer);

    return result != 0;
  }
}
