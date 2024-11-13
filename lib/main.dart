import 'env.dart';

const buildType = BuildType.windows;

Future<void> main() async {
  Env.newInstance(buildType).run();
}