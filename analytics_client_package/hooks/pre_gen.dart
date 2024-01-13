import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;

enum Client {
  firebase,
  custom,
}

Future<void> run(HookContext context) async {
  await _generateInterface(context);
  await _generateClient(context);
}

Future<void> _generateInterface(HookContext context) async {
  final formatProgress =
      context.logger.progress('Making brick analytics_client_interface');
  final brick = Brick.git(
    GitPath(
      'https://github.com/LUSEDOU/bricks.git',
      path: 'analytics_client_interface',
    ),
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
  formatProgress.complete('Made brick analytics_client_interface');
  context.logger.logFilesGenerated(files.length);
}

Future<void> _generateClient(HookContext context) async {
  final client = _clientFromContext(context);
  String name = client.name;
  final formatProgress =
      context.logger.progress('Making brick ${client.brick}');
  final brick = Brick.git(
    GitPath(
      'https://github.com/LUSEDOU/bricks.git',
      path: client.brick,
    ),
  );

  final generator = await MasonGenerator.fromBrick(brick);
  final vars = <String, dynamic>{'path': '../analytics_client'};

  if (client == Client.custom) {
    context.logger.info(
      '\nYou have chosen to make a custom analytics client. '
      'Please fill out the following information:',
    );
    name = context.logger.prompt(
      'What is the name of your analytics client?',
    );
    vars['name'] = name;
    vars['path_to_client'] = '../analytics_client/';
    vars['package'] = context.logger.prompt(
      'What is the package name of your analytics client?',
    );
    vars['version'] = context.logger.prompt(
      'What is the version of your analytics client?',
    );
    final useFlutter = context.logger.prompt(
      'Does the package need the flutter sdk? (y/N)',
      defaultValue: 'N',
    );
    vars['use_flutter'] = useFlutter == 'y';
  }

  final directory = Directory(path.join(Directory.current.path,
      'analytics_client', '${name.snakeCase}_analytics_client'));
  final target = DirectoryGeneratorTarget(directory);
  final files = await generator.generate(
    target,
    vars: vars,
    logger: context.logger,
    fileConflictResolution: FileConflictResolution.overwrite,
  );
  await generator.hooks.postGen();
  formatProgress.complete('Made brick $name');
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
        return 'firebase';
      case Client.custom:
        return '';
    }
  }

  String get brick {
    switch (this) {
      case Client.firebase:
        return 'firebase_analytics_client';
      case Client.custom:
        return 'analytics_client';
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
