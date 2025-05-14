import 'headers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // TodoDb.instance.initDataBase();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
