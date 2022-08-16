import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Language'),
          Container(
            child: Row(
              children: [
                Text('English'),

              ],
            ),)
        ],
      ),
    );
  }
}
