// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubrica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rubrica _$RubricaFromJson(Map<String, dynamic> json) => Rubrica(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      criterios: (json['criterios'] as List<dynamic>)
          .map((e) => Criterio.fromJson(e as Map<String, dynamic>))
          .toList(),
      tieneProcedimientos: json['tieneProcedimientos'] as bool,
      tienePatologias: json['tienePatologias'] as bool,
    );

Map<String, dynamic> _$RubricaToJson(Rubrica instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'criterios': instance.criterios,
      'tieneProcedimientos': instance.tieneProcedimientos,
      'tienePatologias': instance.tienePatologias,
    };
