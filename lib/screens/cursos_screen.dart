import 'package:flutter/material.dart';

class CursosScreen extends StatelessWidget {
  const CursosScreen({Key? key}) : super(key: key);

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
                child: ListView(
              children: [
                _item(context, "CONSTR. APLIC.MÓVILES (INGLÉS)",
                    "202110_ISIS3510_02"),
                _item(context, "BIOL. ORGANISMOS-TEO", "202110_BIOL1300_02"),
                _item(
                    context,
                    "COMPUTACION FORENSE: DELITOS INFORMATICOS, ASPECTOS LEGALES Y EVIDENCIA DIGITAL",
                    "202110_MSIN4206_01"),
                _item(context, "DERECHOS DE AUTOR (3 CREDITOS)",
                    "202110_DERE3210_01")
              ],
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
          Navigator.pushNamed(context, '/calificar');
        },
      ),
      margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
    );
  }
}
