import 'package:remind_me/core/config/config.dart';
import 'package:remind_me/core/widgets/binding.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_dev.g.dart';

// TODO(team): Add the Config.dev() factory in config.dart.
@Riverpod(keepAlive: true)
Config config(ConfigRef ref) {
  return Config.dev();
}

void main() => run();
