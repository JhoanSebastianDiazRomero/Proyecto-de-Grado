// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubrica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rubrica _$RubricaFromJson(Map<String, dynamic> json) => Rubrica(
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      criterios: (json['criterios'] as List<dynamic>)
          .map((e) => Criterio.fromJson(e as Map<String, dynamic>))
          .toList(),
      tieneProcedimientos: json['tieneProcedimientos'] as bool,
      procedimientosSeleccionados:
          (json['procedimientosSeleccionados'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      tienePatologias: json['tienePatologias'] as bool,
      patologiasSeleccionadas:
          (json['patologiasSeleccionadas'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      comentarioGeneral: json['comentarioGeneral'] as String,
    )..id = json['id'] as String;

Map<String, dynamic> _$RubricaToJson(Rubrica instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'criterios': instance.criterios,
      'tieneProcedimientos': instance.tieneProcedimientos,
      'procedimientosSeleccionados': instance.procedimientosSeleccionados,
      'tienePatologias': instance.tienePatologias,
      'patologiasSeleccionadas': instance.patologiasSeleccionadas,
      'comentarioGeneral': instance.comentarioGeneral,
    };
