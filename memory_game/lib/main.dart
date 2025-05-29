import 'package:flutter/material.dart';
import 'game_screen.dart';

void main() {
  runApp(MyApp());
}

class ThemeController extends InheritedWidget {
  final ValueNotifier<bool> isDarkTheme;

  ThemeController({
    required this.isDarkTheme,
    required Widget child,
  }) : super(child: child);

  static ThemeController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeController>();
  }

  @override
  bool updateShouldNotify(ThemeController oldWidget) =>
      isDarkTheme != oldWidget.isDarkTheme;
}

class MyApp extends StatelessWidget {
  final ValueNotifier<bool> isDarkTheme = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      isDarkTheme: isDarkTheme,
      child: ValueListenableBuilder<bool>(
        valueListenable: isDarkTheme,
        builder: (context, isDark, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: isDark ? ThemeData.dark() : ThemeData.light(),
            home: GameScreen(),
          );
        },
      ),
    );
  }
}
