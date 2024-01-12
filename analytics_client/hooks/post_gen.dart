import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runPubGet(context);
  await _runFormat(context);
}

Future<void> _runPubGet(HookContext context) async {
  final formatProgress = context.logger.progress('Running "flutter pub get"');
  await Process.run('flutter', ['pub', 'get']);
  formatProgress.complete();
}

Future<void> _runFormat(HookContext context) async {
  final formatProgress = context.logger.progress('Running "dart format ."');
  await Process.run('dart', ['format', '.']);
  formatProgress.complete();
}
