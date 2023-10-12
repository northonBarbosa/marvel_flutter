import 'package:flutter/material.dart';
import 'package:flutter_marvel/src/app_utils/app_padding_multiplier.dart';

class AppSpacing {
  static Widget verticalSpace({PaddingMultiplier multiplier = PaddingMultiplier.x1}) {
    return SizedBox(height: multiplier.value);
  }

  static Widget horizontalSpace({PaddingMultiplier multiplier = PaddingMultiplier.x1}) {
    return SizedBox(width: multiplier.value);
  }
}
