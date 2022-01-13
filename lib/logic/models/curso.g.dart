// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curso.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Curso _$CursoFromJson(Map<String, dynamic> json) => Curso(
      nombre: json['nombre'] as String,
      codigo: json['codigo'] as String,
      estudiantes: (json['estudiantes'] as List<dynamic>?)
          ?.map((e) => Estudiante.fromJson(e as Map<String, dynamic>))
          .toList(),
      rubricas: (json['rubricas'] as List<dynamic>?)
          ?.map((e) => Rubrica.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CursoToJson(Curso instance) => <String, dynamic>{
      'nombre': instance.nombre,
      'codigo': instance.codigo,
      'estudiantes': instance.estudiantes,
      'rubricas': instance.rubricas,
    };
