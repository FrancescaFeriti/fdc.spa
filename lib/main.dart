import 'package:flow1_prova/database/database.dart';
import 'package:flow1_prova/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flow1_prova/Repository/databaseRepository.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final databaseRepository = DatabaseRepository(database: database);

  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: const MyApp(),
  ));
} //main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  } //build
}//MyApp

