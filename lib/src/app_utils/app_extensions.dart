import 'package:dartz/dartz.dart';

extension EitherExtension<l, r> on Either<l, r> {
  r? getRight() => fold<r?>((_) => null, (right) => right);
  l? getLeft() => fold<l?>((left) => left, (_) => null);
}
