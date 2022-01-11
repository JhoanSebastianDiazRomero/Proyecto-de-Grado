// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estudiante.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Estudiante _$EstudianteFromJson(Map<String, dynamic> json) => Estudiante(
      nombre: json['nombre'] as String,
      codigo: json['codigo'] as String,
      urlImagen: json['urlImagen'] as String?,
      estadosRubricas: (json['estadosRubricas'] as List<dynamic>?)
          ?.map((e) => EstadoRubrica.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EstudianteToJson(Estudiante instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'codigo': instance.codigo,
      'urlImagen': instance.urlImagen,
      'estadosRubricas': instance.estadosRubricas,
    };
