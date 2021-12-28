import 'package:json_annotation/json_annotation.dart';
//flutter pub run build_runner build
part 'course.g.dart';

@JsonSerializable()
class Course {
  String nombre;
  String codigo;

  Course(this.nombre, this.codigo);

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
