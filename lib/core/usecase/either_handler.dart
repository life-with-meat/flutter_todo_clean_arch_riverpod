import 'package:flutter_todo_clean_arch_riverpod/core/logger/app_logger.dart';
import 'package:fpdart/fpdart.dart';

/// 共通の例外 → Either 変換処理
Future<Either<E, T>> toEither<E, T>({
  required Future<T> Function() action,
  E Function(Object error)? onError,
}) async {
  try {
    final result = await action();
    return right(result);
  } catch (error, stackTrace) {
    AppLogger.error('エラーが発生しました', error, stackTrace);
    if (onError != null) {
      return left(onError(error));
    } else if (error is E) {
      return left(error as E);
    } else {
      rethrow; // 予期しない型のエラーは再スロー
    }
  }
}
