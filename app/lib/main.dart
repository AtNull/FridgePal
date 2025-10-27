import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_pal/ui/screens/home.dart';
import 'package:fridge_pal/util/theme_constants.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light
    )
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          surface: Color(0xFFF8FFF5),
          primary: Color(0xFFCAEAB4),
          onPrimary: Colors.black,
          error: Color(0xFFB00020)
        ),
        fontFamily: 'Lexend',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFCAEAB4),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
            borderSide: const BorderSide(color: Colors.black, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: cornerRadius,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            fixedSize: const Size(mediumWidgetHeight, mediumWidgetHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(64, mediumWidgetHeight),
            padding: const EdgeInsets.symmetric(horizontal: cornerRadius),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          )
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(64, mediumWidgetHeight),
            padding: const EdgeInsets.symmetric(horizontal: cornerRadius),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionHandleColor: Colors.black,
        ),
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.black,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: const Color(0xFFCAEAB4),
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
