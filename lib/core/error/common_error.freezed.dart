// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommonError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommonError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommonError()';
}


}

/// @nodoc
class $CommonErrorCopyWith<$Res>  {
$CommonErrorCopyWith(CommonError _, $Res Function(CommonError) __);
}


/// @nodoc


class UnexpectedError extends CommonError {
  const UnexpectedError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommonError.unexpectedError()';
}


}




/// @nodoc


class NetworkError extends CommonError {
  const NetworkError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommonError.networkError()';
}


}




/// @nodoc


class CacheError extends CommonError {
  const CacheError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommonError.cacheError()';
}


}




/// @nodoc


class InvalidInputError extends CommonError {
  const InvalidInputError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidInputError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommonError.invalidInputError()';
}


}




/// @nodoc


class TimeoutError extends CommonError {
  const TimeoutError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CommonError.timeoutError()';
}


}




/// @nodoc


class FirebaseError extends CommonError {
  const FirebaseError(this.code, this.message): super._();
  

 final  String code;
 final  String message;

/// Create a copy of CommonError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirebaseErrorCopyWith<FirebaseError> get copyWith => _$FirebaseErrorCopyWithImpl<FirebaseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirebaseError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'CommonError.firebaseError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $FirebaseErrorCopyWith<$Res> implements $CommonErrorCopyWith<$Res> {
  factory $FirebaseErrorCopyWith(FirebaseError value, $Res Function(FirebaseError) _then) = _$FirebaseErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$FirebaseErrorCopyWithImpl<$Res>
    implements $FirebaseErrorCopyWith<$Res> {
  _$FirebaseErrorCopyWithImpl(this._self, this._then);

  final FirebaseError _self;
  final $Res Function(FirebaseError) _then;

/// Create a copy of CommonError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(FirebaseError(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
