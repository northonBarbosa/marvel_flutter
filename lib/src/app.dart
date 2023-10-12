import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_colors.dart';
import 'package:flutter_marvel/src/view/character_details/character_details_copy.dart';
import 'package:flutter_marvel/src/view/characters_list/characters_list_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      theme: ThemeData(
        primaryColor: AppColors.primaryRed,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.primaryRed),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
          circularTrackColor: AppColors.primaryRed,
        ),
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case CharacterDetailsView.routeName:
                return CharacterDetailsView(characterId: routeSettings.arguments as int);
              default:
                return const CharactersListView();
            }
          },
        );
      },
    );
  }
}
