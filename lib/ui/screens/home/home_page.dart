import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/provider/task_categorie.dart';

import 'package:todo_app/ui/screens/add_task_categ/add_task_categ.dart';
import 'package:todo_app/ui/screens/home/task_categ_list.dart';
import 'package:todo_app/ui/screens/profile/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [const TaskCategList(), const ProfileScreen()];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskCategorie>(
      builder: (context, value, child) => Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(color: Colors.cyan),
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pie_chart_outline_outlined,
                    size: 35,
                  ),
                  label: "")
            ],
          ),
          floatingActionButton: value.floatingActionButton(function: () {
            showDialog(context: context, builder: (_) => const AddTaskCateg());
          }),
          body: pages.elementAt(selectedIndex)),
    );
  }
}
