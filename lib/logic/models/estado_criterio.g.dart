// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado_criterio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstadoCriterio _$EstadoCriterioFromJson(Map<String, dynamic> json) =>
    EstadoCriterio(
      itemSeleccionado: json['itemSeleccionado'] as int? ?? -1,
      comentario: json['comentario'] as String,
    );

Map<String, dynamic> _$EstadoCriterioToJson(EstadoCriterio instance) =>
    <String, dynamic>{
      'itemSeleccionado': instance.itemSeleccionado,
      'comentario': instance.comentario,
    };
