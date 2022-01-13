import 'package:json_annotation/json_annotation.dart';
import 'estudiante.dart';
import 'rubrica.dart';

//flutter pub run build_runner build
part 'curso.g.dart';

@JsonSerializable()
class Curso {
  String nombre;
  String codigo;
  List<Estudiante> estudiantes;
  List<Rubrica> rubricas;

  Curso(
      {required this.nombre,
      required this.codigo,
      List<Estudiante>? estudiantes,
      List<Rubrica>? rubricas})
      : estudiantes = estudiantes ?? [],
        rubricas = rubricas ?? [];

  Curso copyWith(
      {String? nombre,
      String? codigo,
      List<Estudiante>? estudiantes,
      List<Rubrica>? rubricas}) {
    return Curso(
        nombre: nombre ?? this.nombre,
        codigo: codigo ?? this.codigo,
        estudiantes: estudiantes ?? this.estudiantes,
        rubricas: rubricas ?? this.rubricas);
  }

  @override
  String toString() {
    return "Curso: nombre: " +
        nombre +
        " codigo: " +
        codigo +
        "estudiantes: " +
        estudiantes.toString() +
        " rubricas: " +
        rubricas.toString();
  }

  factory Curso.fromJson(Map<String, dynamic> json) => _$CursoFromJson(json);
  Map<String, dynamic> toJson() => _$CursoToJson(this);
}
