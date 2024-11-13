# flutter_ffi_windows_memory_patch

이 프로그램은 Dart와 Flutter 기반으로, Windows 플랫폼에서 동작하는 메모리 패치 프로그램입니다.<br>
C++로 작성된 DLL을 통해 Windows API와 상호작용하며, 특정 프로세스의 메모리에 접근하여 데이터를 읽고 수정할 수 있습니다.<br>
주로 FFI(Foreign Function Interface)를 통해 C++의 기능을 Dart와 연동하여 구현되었으며, GetX 아키텍처를 사용해 상태관리를 효율적으로 처리합니다.

## 개발 환경
- OS: Windows 10 이상
- IDE: Visual Studio Code (권장) 또는 Android Studio
- Flutter SDK: 3.x 이상
- C++ 컴파일러: Visual Studio의 MSVC 컴파일러 (C++ DLL 빌드를 위한 필수 도구)

## 설치 및 실행 방법
1. 이 저장소를 클론합니다.
```shell
git clone https://github.com/hoowave/flutter_ffi_memory_patch.git
```
2. 필요한 패키지를 설치합니다.
```shell
flutter pub get
```
3. Windows 환경에서 애플리케이션을 실행하여 메모리 패치 기능을 사용해보세요.

## 사용 기술
- Flutter & Dart: 친화적인 UI와 크로스 플랫폼 애플리케이션 제작
- FFI (Foreign Function Interface): Flutter와 네이티브 C++ DLL 간의 상호작용을 지원
- Windows API: 프로세스 메모리 읽기 및 쓰기 기능을 제공하여 Windows 환경에 최적화

## 주요 기능
- 친화적인 UI : Flutter로 제작된 UI를 통해 누구나 손쉽게 메모리 패치 기능을 사용할 수 있도록 설계되었습니다.
- 효율적인 메모리 접근 : Windows 프로세스의 메모리를 읽고 쓸 수 있어, 복잡한 툴 없이도 간단한 작업이 가능합니다.
- Windows 플랫폼 최적화 : Windows 전용 API를 사용하여 높은 호환성과 성능을 제공합니다.
- GetX 아키텍처 사용 : Flutter의 상태 관리와 종속성 주입을 효율적으로 관리할 수 있는 GetX 아키텍처를 채택했습니다.

## 작동 방식
- Flutter UI에서 사용자가 주소와 값을 입력하여 메모리 읽기 또는 쓰기 작업을 요청합니다.
- ffi를 통해 Windows API와 상호작용하며, C++ DLL을 사용하여 프로세스의 메모리를 직접 수정합니다.
- 작업 결과는 UI에 반영되어 사용자가 실시간으로 확인할 수 있습니다.

## [누가 개발했어?](https://linktr.ee/hoowave)