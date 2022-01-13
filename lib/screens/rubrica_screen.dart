import 'package:flutter/material.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:tesis/screens/rubrica_detail_screen.dart';

class ListaRubricasScreen extends StatelessWidget {
  final Curso curso;
  const ListaRubricasScreen({Key? key, required this.curso}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rubricas"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: curso.rubricas.length,
                    itemBuilder: (context, index) {
                      return _item(context, curso.rubricas.elementAt(index),
                          curso.estudiantes);
                    })),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _item(context, rubrica, estudiantes) {
    return Card(
      child: ExpansionTile(
        title: Text(rubrica.nombre),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Column(
              children: [
                Text(rubrica.descripcion),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      final page = RubricaScreen(
                          curso: curso, rubricaEscogida: rubrica.id);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => page));
                    },
                    child: const Text('Calificar'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1C958E),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
    );
  }
}
