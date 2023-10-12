part of "crud_bloc.dart";

abstract class CrudState extends Equatable {
  const CrudState();
}

class CrudInitial extends CrudState {
  @override
  List<Object?> get props => [];
}

class DisplayTodos extends CrudState {
  final List<Todo> todos;
  const DisplayTodos({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class DisplaySpecificTodo extends CrudState {
  final Todo todo;
  const DisplaySpecificTodo({required this.todo});

  @override
  List<Object?> get props => [todo];
}