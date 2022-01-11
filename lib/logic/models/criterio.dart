import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'criterio_item.dart';

//flutter pub run build_runner build
part 'criterio.g.dart';

@JsonSerializable()
class Criterio {
  String id /* = Uuid().v4() */;
  String descripcion;
  List<CriterioItem> items;

  Criterio({required this.id, required this.descripcion, required this.items});

  Criterio copyWith(
      {String? id,
      String? descripcion,
      List<CriterioItem>? items,
      String? comentario,
      int? itemSeleccionado}) {
    return Criterio(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        items: items ?? this.items);
  }

  factory Criterio.fromJson(Map<String, dynamic> json) =>
      _$CriterioFromJson(json);
  Map<String, dynamic> toJson() => _$CriterioToJson(this);
}
