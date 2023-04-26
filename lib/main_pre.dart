import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:remind_me/core/config/config.dart';
import 'package:remind_me/core/widgets/binding.dart';

part 'main_pre.g.dart';

// TODO(team): Add the Config.pre() factory in config.dart.
@Riverpod(keepAlive: true)
Config config(ConfigRef ref) {
  return Config.pre();
}

void main() => run();