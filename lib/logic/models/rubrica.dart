import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'criterio.dart';
import 'p_item.dart';

//flutter pub run build_runner build
part 'rubrica.g.dart';

@JsonSerializable()
class Rubrica {
  String id = Uuid().v4();

  String nombre;
  String descripcion;
  List<Criterio> criterios;
  bool tieneProcedimientos;
  List<String> procedimientosSeleccionados;
  bool tienePatologias;
  List<String> patologiasSeleccionadas;
  String comentarioGeneral;

  Rubrica(
      {required this.nombre,
      required this.descripcion,
      required this.criterios,
      required this.tieneProcedimientos,
      required this.procedimientosSeleccionados,
      required this.tienePatologias,
      required this.patologiasSeleccionadas,
      required this.comentarioGeneral});

  Rubrica copyWith(
      {String? nombre,
      String? descripcion,
      List<Criterio>? criterios,
      bool? tieneProcedimientos,
      List<String>? procedimientosSeleccionados,
      bool? tienePatologias,
      List<String>? patologiasSeleccionadas,
      String? comentarioGeneral,
      int? criterioSeleccionado}) {
    return Rubrica(
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        criterios: criterios ?? this.criterios,
        tieneProcedimientos: tieneProcedimientos ?? this.tieneProcedimientos,
        procedimientosSeleccionados:
            procedimientosSeleccionados ?? this.procedimientosSeleccionados,
        tienePatologias: tienePatologias ?? this.tienePatologias,
        patologiasSeleccionadas:
            patologiasSeleccionadas ?? this.patologiasSeleccionadas,
        comentarioGeneral: comentarioGeneral ?? this.comentarioGeneral);
  }

  factory Rubrica.fromJson(Map<String, dynamic> json) =>
      _$RubricaFromJson(json);
  Map<String, dynamic> toJson() => _$RubricaToJson(this);
}
