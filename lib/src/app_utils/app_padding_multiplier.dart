const double _appBasePadding = 4;

enum PaddingMultiplier { x1, x2, x3, x4, x5, x6, x8, zero }

extension PaddingMultiplierExtension on PaddingMultiplier {
  double get value {
    switch (this) {
      case PaddingMultiplier.x2:
        return _appBasePadding * 2;
      case PaddingMultiplier.x3:
        return _appBasePadding * 3;
      case PaddingMultiplier.x4:
        return _appBasePadding * 4;
      case PaddingMultiplier.x5:
        return _appBasePadding * 5;
      case PaddingMultiplier.x6:
        return _appBasePadding * 6;
      case PaddingMultiplier.x8:
        return _appBasePadding * 8;
      case PaddingMultiplier.zero:
        return 0;
      default:
        return _appBasePadding;
    }
  }
}
