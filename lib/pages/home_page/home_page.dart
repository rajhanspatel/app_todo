import 'package:flutter/material.dart';
import 'package:app_todo/headers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TodoController mutable = Provider.of<TodoController>(context);
    TodoController unmutable = Provider.of<TodoController>(context);

    String formatTime(DateTime dt) {
      final time = dt.toLocal().toString().split(' ').last;
      return time.substring(0, 5); // HH:mm format
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Todos"),
      ),
      child: ListView.builder(
        itemCount: mutable.todos.length,
        itemBuilder: (context, index) => mutable.todos[index] != "Add todo"
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.antiAlias,
                child: Card(
                  child: CupertinoListTile(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => CupertinoActionSheet(
                          title: Text('Todo: ${mutable.todos[index].title}'),
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            isDestructiveAction: true,
                            child: const Text('Cancel'),
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      unmutable.deleteTodo(
                                        mutable.todos[index],
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Remove'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    title: Text(
                      mutable.todos[index].title,
                      style: TextStyle(
                        color: mutable.todos[index].dateTime
                                .isBefore(DateTime.now())
                            ? Colors.red
                            : Colors.green,
                        decoration: mutable.todos[index].completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      "Time to be Completed: ${formatTime(mutable.todos[index].dateTime)}\n"
                      "Pending Minutes: ${mutable.todos[index].dateTime.difference(DateTime.now()).inMinutes.toString().padLeft(3, '0')}",
                      style: TextStyle(
                        color: mutable.todos[index].dateTime
                                .isBefore(DateTime.now())
                            ? Colors.red
                            : Colors.green,
                        decoration: mutable.todos[index].completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: CupertinoCheckbox(
                      value: mutable.todos[index].completed,
                      onChanged: (value) {
                        unmutable.toggleTodo(mutable.todos[index]);
                      },
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              )
            : Card(
                color: Colors.blueAccent.shade200.withOpacity(0.65),
                child: CupertinoListTile(
                  leading: const Icon(CupertinoIcons.add),
                  title: Text(mutable.todos[index]),
                  onTap: () {
                    Todo todo = Todo(
                      title: "title",
                      completed: false,
                      dateTime: DateTime.now(),
                    );

                    showCupertinoModalPopup(
                      context: context,
                      builder: (_) => CupertinoActionSheet(
                        title: const Text('Add new Todo'),
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          isDestructiveAction: true,
                          child: const Text('Cancel'),
                        ),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                CupertinoTextField(
                                  style: const TextStyle(
                                    color: CupertinoColors.black,
                                  ),
                                  clearButtonMode:
                                      OverlayVisibilityMode.editing,
                                  placeholder: "Add Todo",
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) {
                                    todo.title = value;
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Pick data'),
                                    CupertinoButton(
                                      onPressed: () {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (_) => CupertinoActionSheet(
                                            title: const Text('Add time'),
                                            actions: [
                                              SizedBox(
                                                height: 200,
                                                width: double.infinity,
                                                child: CupertinoDatePicker(
                                                  initialDateTime:
                                                      DateTime.now(),
                                                  mode: CupertinoDatePickerMode
                                                      .dateAndTime,
                                                  use24hFormat: true,
                                                  onDateTimeChanged:
                                                      (dateTime) {
                                                    todo.dateTime = dateTime;
                                                  },
                                                ),
                                              ),
                                            ],
                                            cancelButton:
                                                CupertinoActionSheetAction(
                                              isDefaultAction: true,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Save & Exit'),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Pick data'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              mutable.addTodo(todo);
                              Navigator.pop(context);
                            },
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
