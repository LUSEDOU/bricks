import 'package:mason/mason.dart';

void run(HookContext context) {
  final path = context.vars['path_to_client'] as String;

  // Change the &#x2F; to / in the path
  final newPath = path.replaceAll('&#x2F;', '/');
  context.vars['path_to_client'] = newPath;
}
