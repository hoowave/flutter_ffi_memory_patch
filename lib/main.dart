import 'env.dart';

const buildType = BuildType.mac;

Future<void> main() async {
  Env.newInstance(buildType).run();
}