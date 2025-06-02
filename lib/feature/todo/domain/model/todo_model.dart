import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/value/todo_title.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    @JsonKey(toJson: _titleToJson, fromJson: _titleFromJson)
    required TodoTitle title,
    required bool isDone,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}

// TodoTitleのJSON変換用のヘルパー関数
Map<String, dynamic> _titleToJson(TodoTitle title) => title.toJson();
TodoTitle _titleFromJson(Map<String, dynamic> json) => TodoTitle.fromJson(json);
