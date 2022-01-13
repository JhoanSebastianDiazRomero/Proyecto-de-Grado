import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tesis/logic/models/models.dart';

class ApiClient {
  ApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  final http.Client _httpClient;

  static const _procedimientosUrl =
      'https://gist.githubusercontent.com/JhoanSebastianDiazRomero/a3d1660216cca826e33144604477c617/raw/85e682d551a2ad66530de6c98a4a0599c3ba856e/procedimientos.json';

  static const _patologiasUrl =
      'https://gist.githubusercontent.com/JhoanSebastianDiazRomero/e116d333b13b5c7e059bab8870149900/raw/5cdfdc0d9ebef1afc3814b7ffdbebee00d7fa1dd/patologias.json';

  static const _cursoUrl =
      'https://gist.githubusercontent.com/JhoanSebastianDiazRomero/08079b76f11b15572cef6c78aed0db46/raw/66f825fccf8a58c1ceeb51fe1a910bdf3a2c6d07/cursos.json';

  Future<List<PItem>> getProcedimientos() async {
    final procedimientosRequest = Uri.parse(_procedimientosUrl);

    final procedimientosResponse = await _httpClient.get(procedimientosRequest);

    final procedimientosJson = jsonDecode(procedimientosResponse.body) as List;

    List<PItem> procedimientos =
        procedimientosJson.map((i) => PItem.fromJson(i)).toList();

    return procedimientos;
  }

  Future<List<PItem>> getPatologias() async {
    final patologiasRequest = Uri.parse(_patologiasUrl);

    final patologiasResponse = await _httpClient.get(patologiasRequest);

    final patologiasJson = jsonDecode(patologiasResponse.body) as List;

    List<PItem> patologias =
        patologiasJson.map((i) => PItem.fromJson(i)).toList();

    return patologias;
  }

  Future<List<Curso>> getCursos() async {
    final cursosRequest = Uri.parse(_cursoUrl);

    final cursosResponse = await _httpClient.get(cursosRequest);

    final cursosJson = jsonDecode(cursosResponse.body) as List;

    List<Curso> cursos = cursosJson.map((i) => Curso.fromJson(i)).toList();

    return cursos;
  }

  bool login(String usuario, String contrasena) {
    return true;
  }

  void postCurso(Curso curso) {
    final json = jsonEncode(curso);
    print(json);
  }
}
