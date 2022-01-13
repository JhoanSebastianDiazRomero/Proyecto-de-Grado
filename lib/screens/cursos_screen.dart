import 'package:flutter/material.dart';
import 'package:tesis/logic/models/curso.dart';
import 'package:tesis/screens/rubrica_screen.dart';
import '../logic/models/models.dart';

class CursosScreen extends StatelessWidget {
  final List<Curso> cursos;
  const CursosScreen({Key? key, required this.cursos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cursos"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                return _item(context, cursos.elementAt(index));
              },
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _item(context, Curso curso) {
    return Card(
      child: ListTile(
        title: Text(curso.nombre),
        subtitle: Text(curso.codigo),
        onTap: () {
          final page = ListaRubricasScreen(
            curso: curso,
          );
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
      ),
      margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
    );
  }
}
