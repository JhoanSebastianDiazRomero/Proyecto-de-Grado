import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'criterio_item.dart';

//flutter pub run build_runner build
part 'criterio.g.dart';

@JsonSerializable()
class Criterio {
  String id = Uuid().v4();
  String descripcion;
  List<CriterioItem> items;
  String comentario;
  int itemSeleccionado;

  Criterio(
      {required this.descripcion,
      required this.items,
      required this.comentario,
      this.itemSeleccionado = -1});

  Criterio copyWith(
      {String? descripcion,
      List<CriterioItem>? items,
      String? comentario,
      int? itemSeleccionado}) {
    return Criterio(
        descripcion: descripcion ?? this.descripcion,
        items: items ?? this.items,
        comentario: comentario ?? this.comentario,
        itemSeleccionado: itemSeleccionado ?? this.itemSeleccionado);
  }

  factory Criterio.fromJson(Map<String, dynamic> json) =>
      _$CriterioFromJson(json);
  Map<String, dynamic> toJson() => _$CriterioToJson(this);
}
