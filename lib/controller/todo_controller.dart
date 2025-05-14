import 'package:app_todo/headers.dart';
import 'package:app_todo/modal/todo_modal.dart';

class TodoController with ChangeNotifier {
  TodoController() {
    initTodo();
  }

  List todos = [];

  void initTodo() {
    if (todos.contains("Add todo")) {
      todos.remove("Add todo");
      todos.add("Add todo");
    } else {
      todos.add("Add todo");
    }
    notifyListeners();
  }

  void addTodo(Todo todo) {
    todos.add(todo);
    initTodo();
  }

  void deleteTodo(Todo todo) {
    todos.remove(todo);
    initTodo();
  }

  bool toggleTodo(Todo todo) {
    todo.completed = !todo.completed;
    notifyListeners();
    return todo.completed;
  }
}
