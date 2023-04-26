import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:remind_me/core/config/config.dart';
import 'package:remind_me/core/widgets/binding.dart';

part 'main_prod.g.dart';

// TODO(team): Add the Config.prod() factory in config.dart.
@Riverpod(keepAlive: true)
Config config(ConfigRef ref) {
  return Config.prod();
}

void main() => run();