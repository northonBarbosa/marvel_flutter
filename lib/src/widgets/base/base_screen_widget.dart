import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_colors.dart';
import 'package:flutter_marvel/src/app_utils/app_padding.dart';

class BaseScreenWidget extends StatelessWidget {
  const BaseScreenWidget({
    super.key,
    required this.screenTitle,
    required this.child,
  });

  final String screenTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(screenTitle),
        ),
        body: Padding(
          padding: AppPadding.symmetric(),
          child: child,
        ),
      ),
    );
  }
}
