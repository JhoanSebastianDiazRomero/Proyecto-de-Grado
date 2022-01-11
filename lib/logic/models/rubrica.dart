import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'criterio.dart';

//flutter pub run build_runner build
part 'rubrica.g.dart';

@JsonSerializable()
class Rubrica {
  //String id = Uuid().v4();
  String id;
  String nombre;
  String descripcion;
  List<Criterio> criterios;
  bool tieneProcedimientos;
  bool tienePatologias;

  Rubrica(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.criterios,
      required this.tieneProcedimientos,
      required this.tienePatologias});

  Rubrica copyWith(
      {String? id,
      String? nombre,
      String? descripcion,
      List<Criterio>? criterios,
      bool? tieneProcedimientos,
      bool? tienePatologias}) {
    return Rubrica(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        criterios: criterios ?? this.criterios,
        tieneProcedimientos: tieneProcedimientos ?? this.tieneProcedimientos,
        tienePatologias: tienePatologias ?? this.tienePatologias);
  }

  factory Rubrica.fromJson(Map<String, dynamic> json) =>
      _$RubricaFromJson(json);
  Map<String, dynamic> toJson() => _$RubricaToJson(this);
}
