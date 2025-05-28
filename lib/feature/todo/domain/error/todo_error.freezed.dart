// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodoError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoError()';
}


}

/// @nodoc
class $TodoErrorCopyWith<$Res>  {
$TodoErrorCopyWith(TodoError _, $Res Function(TodoError) __);
}


/// @nodoc


class TodoCommonError extends TodoError {
  const TodoCommonError(this.error): super._();
  

 final  CommonError error;

/// Create a copy of TodoError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodoCommonErrorCopyWith<TodoCommonError> get copyWith => _$TodoCommonErrorCopyWithImpl<TodoCommonError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoCommonError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'TodoError.common(error: $error)';
}


}

/// @nodoc
abstract mixin class $TodoCommonErrorCopyWith<$Res> implements $TodoErrorCopyWith<$Res> {
  factory $TodoCommonErrorCopyWith(TodoCommonError value, $Res Function(TodoCommonError) _then) = _$TodoCommonErrorCopyWithImpl;
@useResult
$Res call({
 CommonError error
});


$CommonErrorCopyWith<$Res> get error;

}
/// @nodoc
class _$TodoCommonErrorCopyWithImpl<$Res>
    implements $TodoCommonErrorCopyWith<$Res> {
  _$TodoCommonErrorCopyWithImpl(this._self, this._then);

  final TodoCommonError _self;
  final $Res Function(TodoCommonError) _then;

/// Create a copy of TodoError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(TodoCommonError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as CommonError,
  ));
}

/// Create a copy of TodoError
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CommonErrorCopyWith<$Res> get error {
  
  return $CommonErrorCopyWith<$Res>(_self.error, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

/// @nodoc


class TodoNotFoundError extends TodoError {
  const TodoNotFoundError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoNotFoundError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoError.notFound()';
}


}




/// @nodoc


class TodoDuplicateTitleError extends TodoError {
  const TodoDuplicateTitleError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoDuplicateTitleError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoError.duplicateTitle()';
}


}




/// @nodoc


class TodoInvalidTitleError extends TodoError {
  const TodoInvalidTitleError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoInvalidTitleError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoError.invalidTitle()';
}


}




/// @nodoc


class TodoInvalidStateError extends TodoError {
  const TodoInvalidStateError(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodoInvalidStateError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodoError.invalidState()';
}


}




// dart format on
