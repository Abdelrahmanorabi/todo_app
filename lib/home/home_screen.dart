import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/settings/settings_tab.dart';
import 'package:todo_app/home/tasks_list/tasks_list_tab.dart';
import 'package:todo_app/providers/settings_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SettingsProvider settingsProvider;
  int selectedIndex = 0;
  List<Widget> tabs = [TasksListTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(settingsProvider.currentLanguage == 'en'
            ? AppLocalizations.of(context)!.toDo
            : AppLocalizations.of(context)!.toDo),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (int index) {
            selectedIndex = index;
            setState(() {});
          },
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const StadiumBorder(
          side: BorderSide(width: 4, color: Colors.white),
        ),
        child: const Icon(Icons.add),
      ),
      body: tabs[selectedIndex],
    );
  }
}
