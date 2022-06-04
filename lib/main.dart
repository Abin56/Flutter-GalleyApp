import 'package:flutter/material.dart';
import 'package:fluttergallery/Homescreen.dart';
import 'package:fluttergallery/database/db.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //Registring hive
  if (!Hive.isAdapterRegistered(GalleryModelAdapter().typeId)) {
    Hive.registerAdapter(GalleryModelAdapter());
  }
  await Hive.openBox<GalleryModel>('Gallerys');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home_Screen(),
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
    );
  }
}
