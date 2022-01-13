import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'criterio.dart';

//flutter pub run build_runner build
part 'rubrica.g.dart';

@JsonSerializable()
class Rubrica {
  String id = Uuid().v4();
  String nombre;
  String descripcion;
  List<Criterio> criterios;
  bool tieneProcedimientos;
  bool tienePatologias;

  Rubrica(
      {required this.nombre,
      required this.descripcion,
      required this.criterios,
      required this.tieneProcedimientos,
      required this.tienePatologias});

  Rubrica copyWith(
      {String? nombre,
      String? descripcion,
      List<Criterio>? criterios,
      bool? tieneProcedimientos,
      bool? tienePatologias}) {
    return Rubrica(
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        criterios: criterios ?? this.criterios,
        tieneProcedimientos: tieneProcedimientos ?? this.tieneProcedimientos,
        tienePatologias: tienePatologias ?? this.tienePatologias);
  }

  @override
  String toString() {
    return "Rubrica: id: " +
        id +
        " nombre: " +
        nombre +
        " descreipcion: " +
        descripcion +
        " criterios: " +
        criterios.toString() +
        " tieneProcedimientos: " +
        tieneProcedimientos.toString() +
        " tienePatologias: " +
        tienePatologias.toString();
  }

  factory Rubrica.fromJson(Map<String, dynamic> json) =>
      _$RubricaFromJson(json);
  Map<String, dynamic> toJson() => _$RubricaToJson(this);
}
