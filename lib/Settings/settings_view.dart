import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singapore_transport/riverpod/preferences_provider.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prefs = ref.watch(preferencesProvider);
    return ShadSheet(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      constraints: BoxConstraints(minWidth: 300),
      title: Text(
        "Settings",
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          ShadSwitch(
            value: prefs.containsKey('THEME') ? prefs["THEME"] == 'DARK' : false,
            onChanged: (v) {
              ref
                  .read(preferencesProvider.notifier)
                  .updatePreferences('THEME', v ? 'DARK' : 'LIGHT');
            },
            label: const Text('Dark Mode'),
          ),
        ],
      ),
    );
  }
}
