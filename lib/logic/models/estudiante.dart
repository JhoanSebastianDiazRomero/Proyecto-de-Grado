import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner build
part 'estudiante.g.dart';

@JsonSerializable()
class Estudiante {
  String nombre;
  String codigo;

  Estudiante(this.nombre, this.codigo);

  factory Estudiante.fromJson(Map<String, dynamic> json) =>
      _$EstudianteFromJson(json);
  Map<String, dynamic> toJson() => _$EstudianteToJson(this);
}
