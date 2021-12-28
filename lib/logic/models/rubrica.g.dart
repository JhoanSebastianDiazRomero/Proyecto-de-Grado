// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubrica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rubrica _$RubricaFromJson(Map<String, dynamic> json) => Rubrica(
      json['nombre'] as String,
      json['descripcion'] as String,
      (json['criterios'] as List<dynamic>)
          .map((e) => Criterio.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['tieneProcedimientos'] as bool,
      json['tienePatologias'] as bool,
      json['comentarioGeneral'] as String,
    )..id = json['id'] as String;

Map<String, dynamic> _$RubricaToJson(Rubrica instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'criterios': instance.criterios,
      'tieneProcedimientos': instance.tieneProcedimientos,
      'tienePatologias': instance.tienePatologias,
      'comentarioGeneral': instance.comentarioGeneral,
    };
