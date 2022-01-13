// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado_rubrica.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstadoRubrica _$EstadoRubricaFromJson(Map<String, dynamic> json) =>
    EstadoRubrica(
      idRubrica: json['idRubrica'] as String,
      codigoEstudiante: json['codigoEstudiante'] as String,
      estadosCriterios:
          (json['estadosCriterios'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, EstadoCriterio.fromJson(e as Map<String, dynamic>)),
      ),
      procedimientosSeleccionados:
          (json['procedimientosSeleccionados'] as List<dynamic>?)
              ?.map((e) => PItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      patologiasSeleccionadas:
          (json['patologiasSeleccionadas'] as List<dynamic>?)
              ?.map((e) => PItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      comentarioGeneral: json['comentarioGeneral'] as String?,
    );

Map<String, dynamic> _$EstadoRubricaToJson(EstadoRubrica instance) =>
    <String, dynamic>{
      'idRubrica': instance.idRubrica,
      'codigoEstudiante': instance.codigoEstudiante,
      'estadosCriterios': instance.estadosCriterios,
      'procedimientosSeleccionados': instance.procedimientosSeleccionados,
      'patologiasSeleccionadas': instance.patologiasSeleccionadas,
      'comentarioGeneral': instance.comentarioGeneral,
    };
