// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criterio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Criterio _$CriterioFromJson(Map<String, dynamic> json) => Criterio(
      descripcion: json['descripcion'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CriterioItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      comentario: json['comentario'] as String,
      itemSeleccionado: json['itemSeleccionado'] as int? ?? -1,
    )..id = json['id'] as String;

Map<String, dynamic> _$CriterioToJson(Criterio instance) => <String, dynamic>{
      'id': instance.id,
      'descripcion': instance.descripcion,
      'items': instance.items,
      'comentario': instance.comentario,
      'itemSeleccionado': instance.itemSeleccionado,
    };
