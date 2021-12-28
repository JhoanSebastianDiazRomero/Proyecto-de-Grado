// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criterio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Criterio _$CriterioFromJson(Map<String, dynamic> json) => Criterio(
      json['descripcion'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => CriterioItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['comentario'] as String,
    );

Map<String, dynamic> _$CriterioToJson(Criterio instance) => <String, dynamic>{
      'descripcion': instance.descripcion,
      'items': instance.items,
      'comentario': instance.comentario,
    };
