// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as int?,
      isImportant: json['isImportant'] == 1,
      number: json['number'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      createdTime: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'isImportant': instance.isImportant,
      'number': instance.number,
      'title': instance.title,
      'description': instance.description,
      'time': instance.createdTime.toIso8601String(),
    };
