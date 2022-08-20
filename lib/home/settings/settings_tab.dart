import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/settings/language_bottom_sheet.dart';
import 'package:todo_app/home/settings/theme_bottom_sheet.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  /*=======================[Variables]=====================*/
  late SettingsProvider settingsProvider;

  /*====================================================*/

  /*=====================[Methods]=======================*/
  void showLanguageBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (buildContext) {
          return LanguageBottomSheet();
        });
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (buildContext) {
          return ThemeBottomSheet();
        });
  }

  /*====================================================*/
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              width: 320,
              height: 50,
              margin: const EdgeInsets.only(top: 20, left: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: settingsProvider.isDark()
                      ? MyTheme.darkScaffoldBackground
                      : Colors.white,
                  border: Border.all(color: MyTheme.lightPrimary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      settingsProvider.currentLanguage == 'en'
                          ? 'English'
                          : 'العربية',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 15)),
                  const Icon(Icons.arrow_drop_down_outlined, size: 26)
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              width: 320,
              height: 50,
              margin: EdgeInsets.only(top: 20, left: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: settingsProvider.isDark()
                      ? MyTheme.darkScaffoldBackground
                      : Colors.white,
                  border: Border.all(color: MyTheme.lightPrimary)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      settingsProvider.isDark()
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 15)),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 26,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
