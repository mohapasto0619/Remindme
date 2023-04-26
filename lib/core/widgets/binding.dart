import 'package:remind_me/modules/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:obs_foundation/obs_foundation.dart';

Future<void> run() async {
  // Initialize the loggers.
  initLoggers([
    ConsoleLogger(),
    // Add other loggers here.
  ]);

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
