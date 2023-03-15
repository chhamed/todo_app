import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/controllers/provider/screen_switch.dart';
import 'package:todo_app/controllers/provider/task_categorie_controller.dart';
import 'package:todo_app/ui/screens/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
              ChangeNotifierProvider(create: (_) => TaskCategorieController()),
              ChangeNotifierProvider(create: (_) => ScreenSwitch()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Home(),
            ));
      },
    );
  }
}
