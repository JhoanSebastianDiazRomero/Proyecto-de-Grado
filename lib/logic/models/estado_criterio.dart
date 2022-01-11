import 'package:json_annotation/json_annotation.dart';

//flutter pub run build_runner build
part 'estado_criterio.g.dart';

@JsonSerializable()
class EstadoCriterio {
  int itemSeleccionado;
  String comentario;

  EstadoCriterio({this.itemSeleccionado = -1, this.comentario = ''});

  EstadoCriterio copyWith({int? itemSeleccionado, String? comentario}) {
    return EstadoCriterio(
      itemSeleccionado: itemSeleccionado ?? this.itemSeleccionado,
      comentario: comentario ?? this.comentario,
    );
  }

  factory EstadoCriterio.fromJson(Map<String, dynamic> json) =>
      _$EstadoCriterioFromJson(json);
  Map<String, dynamic> toJson() => _$EstadoCriterioToJson(this);
}
