import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner build
part 'p_item.g.dart';

@JsonSerializable()
class PItem {
  String codigo;
  String nombre;

  PItem({required this.codigo, required this.nombre});

  PItem copyWith({String? codigo, String? nombre}) {
    return PItem(codigo: codigo ?? this.codigo, nombre: nombre ?? this.nombre);
  }

  factory PItem.fromJson(Map<String, dynamic> json) => _$PItemFromJson(json);
  Map<String, dynamic> toJson() => _$PItemToJson(this);
}
