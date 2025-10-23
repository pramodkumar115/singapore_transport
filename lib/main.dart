import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singapore_transport/Home/home_view.dart';
import 'package:singapore_transport/riverpod/preferences_provider.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {

  @override
  void initState() {
    super.initState();
    ref.read(preferencesProvider.notifier).fetchSharedPreferences();
  }

  ThemeMode getThemeMode() {
    var theme = ThemeMode.light;
    Map prefs = ref.watch(preferencesProvider);

    if (prefs.containsKey("THEME")) {
      theme = prefs["THEME"] == 'DARK' ? ThemeMode.dark : ThemeMode.light;
    }
    return theme;
  }

  @override
  Widget build(BuildContext context) {
    return ShadApp.custom(
      themeMode: getThemeMode(),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
      ),
      appBuilder: (context) {
        return MaterialApp(
          home: HomeView(),
          theme: Theme.of(context),
          builder: (context, child) {
            return ShadAppBuilder(child: child!);
          },
        );
      },
    );
  }
}
