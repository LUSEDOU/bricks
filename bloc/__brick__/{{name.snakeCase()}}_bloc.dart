import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '{{name.snakeCase()}}_state.dart';
part '{{name.snakeCase()}}_event.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc() : super(const {{name.pascalCase()}}State()) {
   on<{{name.pascalCase()}}Requested>(_on{{name.pascalCase()}}Requested);
  }

  Future<void> _on{{name.pascalCase()}}Requested(
    {{name.pascalCase()}}Requested event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(state.copyWith(status: {{name.pascalCase()}}Status.loading));
    try {
      emit(state.copyWith(status: {{name.pascalCase()}}Status.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: {{name.pascalCase()}}Status.failure));
      addError(error, stackTrace);
    }
  }
}
