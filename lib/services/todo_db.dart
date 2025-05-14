// import 'package:app_todo/headers.dart';
//
// enum TodoColumn {
//   id,
//   title,
//   completed,
//   dateTime,
// }
//
// class TodoDb {
//   TodoDb._();
//   static final TodoDb instance = TodoDb._();
//
//   String db = "todo_db.db";
//   String tableName = "todo_table";
//   String query = "";
//
//   late Database database;
//   Logger logger = Logger();
//
//   Future<void> initDataBase() async {
//     String path = await getDatabasesPath();
//     database = await openDatabase(
//       "$path/$db",
//       version: 1,
//       onCreate: (db, version) async {
//         query = """CREATE TABLE $tableName IF IS NOT EXISTS (
//           ${TodoColumn.id.name} INTEGER PRIMARY KEY AUTOINCREMENT,
//           ${TodoColumn.title.name} TEXT NOT NULL,
//           ${TodoColumn.completed.name} BOOLEAN NOT NULL,
//           ${TodoColumn.dateTime.name} TEXT NOT NULL);""";
//         await db
//             .execute(query)
//             .then((value) => logger.i("Table created"))
//             .onError(
//                 (error, stackTrace) => logger.e("Table Creating Error $error"));
//       },
//     );
//   }
//
//   Future<List> getTodoFromDatabase() async {
//     List<Map<String, dynamic>> todoList = await database.query(
//       tableName,
//       columns: [
//         TodoColumn.id.name,
//         TodoColumn.title.name,
//         TodoColumn.completed.name,
//         TodoColumn.dateTime.name
//       ],
//     );
//
//     return todoList
//         .map(
//           (e) => Todo.fromJson(e),
//         )
//         .toList();
//   }
// }
