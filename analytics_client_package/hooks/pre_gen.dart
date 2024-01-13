import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

enum Client {
  firebase,
  custom,
}

Future<void> run(HookContext context) async {
  await _generateInterface(context);
}

Future<void> _generateInterface(HookContext context) async {
  final formatProgress =
      context.logger.progress('Making brick analytics_client_interface');
  final brick = Brick.version(
    name: 'analytics_client_interface',
    version: '0.1.0',
  );
  final generator = await MasonGenerator.fromBrick(brick);
  final directory = Directory(path.join(
      Directory.current.path, 'analytics_client', 'analytics_client'));
  final target = DirectoryGeneratorTarget(directory);
  final files = await generator.generate(
    target,
    logger: context.logger,
    fileConflictResolution: FileConflictResolution.overwrite,
  );
  await generator.hooks.postGen();
  formatProgress.complete();
  context.logger.logFilesGenerated(files.length);
}

Client _clientFromContext(HookContext context) {
  final client = context.vars['client'] as String;
  switch (client) {
    case 'firebase':
      return Client.firebase;
    case 'custom':
      return Client.custom;
    default:
      return Client.firebase;
  }
}

extension on Client {
  String get name {
    switch (this) {
      case Client.firebase:
        return 'firebase_analytics_client';
      case Client.custom:
        return 'analytics_client';
    }
  }

  String get directory {
    switch (this) {
      case Client.firebase:
        return this.name;
      case Client.custom:
        return 'analytics_client';
    }
  }

  String get version {
    switch (this) {
      case Client.firebase:
      case Client.custom:
      default:
        return '0.1.0';
    }
  }
}
extension on Logger {
  void logFilesGenerated(int fileCount) {
    if (fileCount == 1) {
      this
        ..info(
          '${lightGreen.wrap('\u2713')} '
          'Generated $fileCount file:',
        )
        ..flush((message) => info(darkGray.wrap(message)));
    } else {
      this
        ..info(
          '${lightGreen.wrap('\u2713')} '
          'Generated $fileCount file(s):',
        )
        ..flush((message) => info(darkGray.wrap(message)));
    }
  }
}
