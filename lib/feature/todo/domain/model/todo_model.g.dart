// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => _TodoModel(
  id: json['id'] as String,
  title: _titleFromJson(json['title'] as Map<String, dynamic>),
  isDone: json['isDone'] as bool,
);

Map<String, dynamic> _$TodoModelToJson(_TodoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': _titleToJson(instance.title),
      'isDone': instance.isDone,
    };
