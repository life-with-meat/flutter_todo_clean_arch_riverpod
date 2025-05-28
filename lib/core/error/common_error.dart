import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_error.freezed.dart';

@freezed
abstract class CommonError with _$CommonError {
  const CommonError._();

  const factory CommonError.unexpectedError() = UnexpectedError;
  const factory CommonError.networkError() = NetworkError;
  const factory CommonError.cacheError() = CacheError;
  const factory CommonError.invalidInputError() = InvalidInputError;
  const factory CommonError.timeoutError() = TimeoutError;

  String get message {
    return switch (this) {
      UnexpectedError() => '予期せぬエラーが発生しました',
      NetworkError() => 'ネットワークエラーが発生しました',
      CacheError() => 'キャッシュエラーが発生しました',
      InvalidInputError() => '無効な入力です',
      TimeoutError() => 'タイムアウトが発生しました',
      _ => throw UnimplementedError(),
    };
  }
}
