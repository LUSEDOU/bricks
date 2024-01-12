import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runDartPubGet(context);
  await _runDartFormat(context);
}

Future<void> _runDartPubGet(HookContext context) async {
  final formatProgress = context.logger.progress('Running "dart pub get"');
  await Process.run('dart', ['pub', 'get']);
  formatProgress.complete();
}

Future<void> _runDartFormat(HookContext context) async {
  final formatProgress = context.logger.progress('Running "dart format ."');
  await Process.run('dart', ['format', '.']);
  formatProgress.complete();
}
