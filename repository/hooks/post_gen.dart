import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  await _runDartPubGet(context);
  await _runDartFormat(context);
  await _runDartFix(context);
}

Future<void> _runDartPubGet(HookContext context) async {
  final formatProgress = context.logger.progress('Running "dart pub get"');
  await Process.run('dart', ['pub', 'get']);
  formatProgress.complete();
}

Future<void> _runDartFormat(HookContext context) async {
  final formatProgress = context.logger.progress('Running "dart format"');
  await Process.run('dart', ['format', '.']);
  formatProgress.complete();
}

Future<void> _runDartFix(HookContext context) async {
  final formatProgress = context.logger.progress('Running "dart fix"');
  await Process.run('dart', ['fix', '.']);
  formatProgress.complete();
}
