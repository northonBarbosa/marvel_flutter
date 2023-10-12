import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_padding_multiplier.dart';

class AppPadding {
  static EdgeInsets symmetric({
    PaddingMultiplier? horizontal,
    PaddingMultiplier? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: horizontal != null ? horizontal.value : PaddingMultiplier.x3.value,
      vertical: vertical != null ? vertical.value : PaddingMultiplier.x2.value,
    );
  }

  static EdgeInsets fromLTRB({
    PaddingMultiplier left = PaddingMultiplier.x2,
    PaddingMultiplier right = PaddingMultiplier.x2,
    PaddingMultiplier top = PaddingMultiplier.x2,
    PaddingMultiplier bottom = PaddingMultiplier.x2,
  }) {
    return EdgeInsets.fromLTRB(
      left.value,
      top.value,
      right.value,
      bottom.value,
    );
  }

  static EdgeInsets only({
    PaddingMultiplier left = PaddingMultiplier.zero,
    PaddingMultiplier right = PaddingMultiplier.zero,
    PaddingMultiplier top = PaddingMultiplier.zero,
    PaddingMultiplier bottom = PaddingMultiplier.zero,
  }) {
    return EdgeInsets.only(
      left: left.value,
      right: right.value,
      top: top.value,
      bottom: bottom.value,
    );
  }
}
