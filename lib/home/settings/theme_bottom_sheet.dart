import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  /*=====================[ِVariables]=======================*/
  late SettingsProvider settingsProvider;

  /*=====================================================*/
  Widget getSelectedRow(String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          border: Border.all(color: MyTheme.lightPrimary),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 25),
          ),
          const Icon(Icons.check,color: Colors.blue,size: 25,)
        ],
      ),
    );
  }

  Widget getUnSelectedRow(String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      // decoration: BoxDecoration(
      //     color: Colors.grey[400],
      //     border: Border.all(color: Colors.grey),
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(15),
      //       topRight: Radius.circular(15),
      //     )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style:
                Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 25),
          ),
        ],
      ),
    );
  }

  /*=====================================================*/
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration:  BoxDecoration(
          color:settingsProvider.isDark()? MyTheme.darkScaffoldBackground:MyTheme.lightScaffoldBackground,
          borderRadius: const BorderRadius. only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        children: [
          InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                settingsProvider.changeTheme(ThemeMode.light);
              },
              child: settingsProvider.isDark()
                  ? getUnSelectedRow(AppLocalizations.of(context)!.light)
                  : getSelectedRow(AppLocalizations.of(context)!.light)),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              settingsProvider.changeTheme(ThemeMode.dark);
            },
            child: settingsProvider.isDark()
                ? getSelectedRow(AppLocalizations.of(context)!.dark)
                : getUnSelectedRow(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }
}
