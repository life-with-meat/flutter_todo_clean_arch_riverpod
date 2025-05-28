import 'package:fpdart/fpdart.dart';

/// 共通の例外 → Either 変換処理
Future<Either<E, T>> toEither<E, T>({
  required Future<T> Function() action,
  E Function(Object error)? onError,
}) async {
  try {
    final result = await action();
    return right(result);
  } catch (error) {
    if (onError != null) {
      return left(onError(error));
    } else if (error is E) {
      return left(error as E);
    } else {
      rethrow; // 予期しない型のエラーは再スロー
    }
  }
}
