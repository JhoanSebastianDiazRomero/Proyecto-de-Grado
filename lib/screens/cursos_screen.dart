import 'package:flutter/material.dart';
import 'package:tesis/logic/models/course.dart';
import 'package:tesis/screens/rubrica_screen.dart';
import '../logic/models/course.dart';

class CursosScreen extends StatelessWidget {
  const CursosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var courses = List<Course>.from([
      Course('CONSTR. APLIC.MÓVILES (INGLÉS)', '202110_ISIS3510_02'),
      Course('BIOL. ORGANISMOS-TEO', '202110_BIOL1300_02'),
      Course(
          'COMPUTACION FORENSE: DELITOS INFORMATICOS, ASPECTOS LEGALES Y EVIDENCIA DIGITAL',
          '202110_MSIN4206_01'),
      Course('DERECHOS DE AUTOR (3 CREDITOS)', '202110_DERE3210_01'),
    ]);
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
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return _item(context, courses.elementAt(index).nombre,
                    courses.elementAt(index).codigo);
              },
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _item(context, nombre_curso, codigo) {
    return Card(
      child: ListTile(
        title: Text(nombre_curso),
        subtitle: Text(codigo),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CalificarRubricaScreen()));
        },
      ),
      margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
    );
  }
}
