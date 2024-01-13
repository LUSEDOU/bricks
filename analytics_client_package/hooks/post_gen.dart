import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runDartPubGet(context);
}

Future<void> _runDartPubGet(HookContext context) async {
  final formatProgress = context.logger.progress('Running "flutter pub get"');
  await Process.run('flutter', ['pub', 'get']);
  formatProgress.complete();
}
