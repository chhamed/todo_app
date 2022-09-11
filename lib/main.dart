import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/controllers/provider/task_categorie.dart';
import 'package:todo_app/ui/screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => TaskCategorie()),
            ],
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Home(),
            ));
      },
    );
  }
}
