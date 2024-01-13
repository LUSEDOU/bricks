import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runPubGet(context);
}

Future<void> _runPubGet(HookContext context) async {
  final formatProgress =
      context.logger.progress('Running "flutter pub get" ...');
  await Process.run('flutter', ['pub', 'get']);
  formatProgress.complete();
}
