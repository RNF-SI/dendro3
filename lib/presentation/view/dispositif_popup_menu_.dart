import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:settings_ui/settings_ui.dart';

// ToDo: use when a setting page is needed
class DispositifPopUpMenu extends ConsumerWidget {
  const DispositifPopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        // popupmenu item 1
        const PopupMenuItem(
          // value: 1,
          // row has two child icon and text.
          child: Row(
            children: [
              Icon(Icons.star),
              SizedBox(
                  // sized box with width 10
                  // width: 10,
                  ),
              Text("Get The App")
            ],
          ),
        ),
        // popupmenu item 2
        const PopupMenuItem(
          // value: 2,
          // row has two child icon and text
          child: Row(
            children: [
              Icon(Icons.chrome_reader_mode),
              SizedBox(
                  // sized box with width 10
                  // width: 10,
                  ),
              Text("About")
            ],
          ),
        ),
      ],
      // offset: Offset(0, 100),
      color: Colors.grey,
      elevation: 2,
    );

    // SettingsList(
    //   sections: [
    //     SettingsSection(
    //       margin: const EdgeInsetsDirectional.all(20),
    //       title: const Text('Dispositif'),
    //       tiles: [
    //         SettingsTile(
    //           title: 'Language',
    //           subtitle: 'English',
    //           leading: Icon(Icons.language),
    //           onPressed: (BuildContext context) {},
    //         ),
    //         SettingsTile.switchTile(
    //           title: 'Use System Theme',
    //           leading: Icon(Icons.phone_android),
    //           switchValue: isSwitched,
    //           onToggle: (value) {
    //             setState(() {
    //               isSwitched = value;
    //             });
    //           },
    //         ),
    //       ],
    //     ),
    //     SettingsSection(
    //       titlePadding: EdgeInsets.all(20),
    //       title: 'Section 2',
    //       tiles: [
    //         SettingsTile(
    //           title: 'Security',
    //           subtitle: 'Fingerprint',
    //           leading: Icon(Icons.lock),
    //           onPressed: (BuildContext context) {},
    //         ),
    //         SettingsTile.switchTile(
    //           title: 'Use fingerprint',
    //           leading: Icon(Icons.fingerprint),
    //           switchValue: true,
    //           onToggle: (value) {},
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
