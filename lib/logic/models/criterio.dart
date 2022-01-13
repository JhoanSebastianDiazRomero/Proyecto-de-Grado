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

  Criterio(this.descripcion, this.items);

  Criterio copyWith(
      {String? descripcion, List<CriterioItem>? items, String? comentario}) {
    return Criterio(descripcion ?? this.descripcion, items ?? this.items);
  }

  @override
  String toString() {
    return "Criterio: id: " +
        id +
        " descripcion: " +
        descripcion +
        " items: " +
        items.toString();
  }

  factory Criterio.fromJson(Map<String, dynamic> json) =>
      _$CriterioFromJson(json);
  Map<String, dynamic> toJson() => _$CriterioToJson(this);
}
