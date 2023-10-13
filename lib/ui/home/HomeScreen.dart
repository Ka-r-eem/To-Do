import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/providers/settingsProvider/SettingsProvider.dart';
import 'package:todo_app/ui/DialogUtils.dart';
import 'package:todo_app/ui/Login/loginScreen.dart';
import 'package:todo_app/ui/home/AddTaskSheet.dart';
import 'package:todo_app/ui/home/TasksList/TasksListTab.dart';
import 'package:todo_app/ui/home/settings/SettingsTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    var settingsProvider = Provider.of<SettingsProvider>(context);

    return Container(
      color: settingsProvider.currentTheme == ThemeMode.light ?Color(0xFFDFECDB): Color(0xFF060E1E),
      child: Scaffold(
        appBar: AppBar(
          title: Text("To Do List"),
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(
              side: BorderSide(width: 4, color: Colors.white)),
          onPressed: () {
            showTaskBottomSheet();
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 12,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ],
          ),
        ),
        body: tabs[selectedIndex],
      ),
    );
  }

  int selectedIndex = 0;

  var tabs = [TasksList() , SettingsTab()];

  void logout() {
    var authProvider = Provider.of<AuthProvider>(context , listen: false);
    DialogUtils.showMessage(context, "Are You Sure To Logout ?",
      posActionTitle: "YES",
      posAction: () {
        authProvider.logout();
        Navigator.pushReplacementNamed(context, login.routeName);
      },
      negActionTitle: "Cancel",

    );
  }

  void showTaskBottomSheet() {
showModalBottomSheet(context: context, builder:(BuildContext){
  return AddTaskSheet();
} );

  }
}
