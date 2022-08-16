import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/settings_provider.dart';

import '../../my_theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
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
          const Icon(
            Icons.check,
            color: Colors.blue,
            size: 25,
          )
        ],
      ),
    );
  }

  Widget getUnSelectedRow(String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey[400],
          border: Border.all(color: Colors.grey),
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
      decoration: BoxDecoration(
          color: settingsProvider.isDark()
              ? MyTheme.darkScaffoldBackground
              : MyTheme.lightScaffoldBackground,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                settingsProvider.changeLanguage('ar');
              },
              child: settingsProvider.currentLanguage == 'ar'
                  ? getSelectedRow('العربية')
                  : getUnSelectedRow('العربية')),
          InkWell(
            onTap: () {
              settingsProvider.changeLanguage('en');
            },
            child: settingsProvider.currentLanguage == 'en'
                ? getSelectedRow('English')
                : getUnSelectedRow('English'),
          ),
        ],
      ),
    );
  }
}
