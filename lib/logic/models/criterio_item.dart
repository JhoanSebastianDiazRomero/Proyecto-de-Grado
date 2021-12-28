import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner build
part 'criterio_item.g.dart';

@JsonSerializable()
class CriterioItem {
  String titulo;
  String descripcion;

  CriterioItem(this.titulo, this.descripcion);

  factory CriterioItem.fromJson(Map<String, dynamic> json) =>
      _$CriterioItemFromJson(json);
  Map<String, dynamic> toJson() => _$CriterioItemToJson(this);
}
