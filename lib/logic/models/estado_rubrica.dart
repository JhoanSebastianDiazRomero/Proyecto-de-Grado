import 'package:json_annotation/json_annotation.dart';
import 'package:tesis/logic/models/estado_criterio.dart';
import 'package:tesis/logic/models/p_item.dart';

//flutter pub run build_runner build
part 'estado_rubrica.g.dart';

@JsonSerializable()
class EstadoRubrica {
  String idRubrica;
  String codigoEstudiante;

  Map<String, EstadoCriterio> estadosCriterios;
  List<PItem> procedimientosSeleccionados;
  List<PItem> patologiasSeleccionadas;
  String comentarioGeneral;

  EstadoRubrica(
      {required this.idRubrica,
      required this.codigoEstudiante,
      Map<String, EstadoCriterio>? estadosCriterios,
      List<PItem>? procedimientosSeleccionados,
      List<PItem>? patologiasSeleccionadas,
      String? comentarioGeneral})
      : estadosCriterios = estadosCriterios ?? <String, EstadoCriterio>{},
        procedimientosSeleccionados = procedimientosSeleccionados ?? [],
        patologiasSeleccionadas = patologiasSeleccionadas ?? [],
        comentarioGeneral = comentarioGeneral ?? '';

  EstadoRubrica copyWith(
      {String? idRubrica,
      String? codigoEstudiante,
      Map<String, EstadoCriterio>? estadosCriterios,
      List<PItem>? procedimientosSeleccionados,
      List<PItem>? patologiasSeleccionadas,
      String? comentarioGeneral}) {
    return EstadoRubrica(
        idRubrica: idRubrica ?? this.idRubrica,
        codigoEstudiante: codigoEstudiante ?? this.codigoEstudiante,
        estadosCriterios: estadosCriterios ?? this.estadosCriterios,
        procedimientosSeleccionados:
            procedimientosSeleccionados ?? this.procedimientosSeleccionados,
        patologiasSeleccionadas:
            patologiasSeleccionadas ?? this.patologiasSeleccionadas,
        comentarioGeneral: comentarioGeneral ?? this.comentarioGeneral);
  }

  @override
  String toString() {
    return "Estado Rubrica: idRubrica: " +
        idRubrica +
        " codigoEstudiante: " +
        codigoEstudiante +
        " estadoCriterios: " +
        estadosCriterios.toString() +
        " procedimientosSeleccionados: " +
        procedimientosSeleccionados.toString() +
        " patologiasSeleccionadas: " +
        patologiasSeleccionadas.toString() +
        "comentarioGeneral: " +
        comentarioGeneral;
  }

  factory EstadoRubrica.fromJson(Map<String, dynamic> json) =>
      _$EstadoRubricaFromJson(json);
  Map<String, dynamic> toJson() => _$EstadoRubricaToJson(this);
}
