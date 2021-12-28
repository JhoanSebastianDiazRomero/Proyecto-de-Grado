import 'package:json_annotation/json_annotation.dart';
import 'criterio_item.dart';

//flutter pub run build_runner build
part 'criterio.g.dart';

@JsonSerializable()
class Criterio {
  String descripcion;
  List<CriterioItem> items;
  String comentario;

  Criterio(this.descripcion, this.items, this.comentario);

  factory Criterio.fromJson(Map<String, dynamic> json) =>
      _$CriterioFromJson(json);
  Map<String, dynamic> toJson() => _$CriterioToJson(this);
}
