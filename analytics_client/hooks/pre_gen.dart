import 'package:mason/mason.dart';

void run(HookContext context) {
  final path = context.vars['path_to_client'] as String;

  // Change the &#x2F; to / in the path
  context.logger.info('Path to client: $path');
  final newPath = path.replaceAll('&#x2F;', '/');
  context.logger.info('Path to client: $newPath');
  context.vars['path_to_client'] = newPath;
}
