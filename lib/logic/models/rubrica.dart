import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'criterio.dart';

//flutter pub run build_runner build
part 'rubrica.g.dart';

@JsonSerializable()
class Rubrica {
  String id = Uuid().v4();

  String nombre;
  String descripcion;
  List<Criterio> criterios;
  bool tieneProcedimientos;
  bool tienePatologias;
  String comentarioGeneral;

  Rubrica(this.nombre, this.descripcion, this.criterios,
      this.tieneProcedimientos, this.tienePatologias, this.comentarioGeneral);

  factory Rubrica.fromJson(Map<String, dynamic> json) =>
      _$RubricaFromJson(json);
  Map<String, dynamic> toJson() => _$RubricaToJson(this);
}
