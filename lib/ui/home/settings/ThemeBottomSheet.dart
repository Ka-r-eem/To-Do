import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/settingsProvider/SettingsProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                settingsProvider.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: settingsProvider.isDarkEnabled() ? getUnselectedItem("light"):
              getSelectedItem("light")),
          InkWell(
              onTap: (){
                settingsProvider.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child:settingsProvider.isDarkEnabled() ? getSelectedItem("dark"):
              getUnselectedItem("dark"))
        ],
      ),
    );
  }

  Widget getSelectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).primaryColor),
        ),
        Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget getUnselectedItem(String text) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                fontSize: 18, color: Theme.of(context).colorScheme.onPrimary)),
      ],
    );
  }
}
