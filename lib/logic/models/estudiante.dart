import 'package:json_annotation/json_annotation.dart';
import 'package:tesis/logic/models/estado_rubrica.dart';
//flutter pub run build_runner build
part 'estudiante.g.dart';

@JsonSerializable()
class Estudiante {
  String nombre;
  String codigo;
  String urlImagen;
  List<EstadoRubrica> estadosRubricas;

  Estudiante(
      {required this.nombre,
      required this.codigo,
      String? urlImagen,
      List<EstadoRubrica>? estadosRubricas})
      : estadosRubricas = estadosRubricas ?? [],
        urlImagen = 'http://cdn.onlinewebfonts.com/svg/img_237553.png';

  Estudiante copyWith(
      {String? nombre, String? codigo, List<EstadoRubrica>? estadosRubricas}) {
    return Estudiante(
        nombre: nombre ?? this.nombre,
        codigo: codigo ?? this.codigo,
        estadosRubricas: estadosRubricas ?? this.estadosRubricas);
  }

  factory Estudiante.fromJson(Map<String, dynamic> json) =>
      _$EstudianteFromJson(json);
  Map<String, dynamic> toJson() => _$EstudianteToJson(this);
}
