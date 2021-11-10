import 'package:flutter/material.dart';

class CalificarRubricaScreen extends StatelessWidget {
  const CalificarRubricaScreen({Key? key}) : super(key: key);

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
                child: ListView(
              children: [
                _item(context, "Consulta Observada",
                    "Desempeno del residente en rotacion de consulta externa"),
                _item(context, "Concepto Enfermeria",
                    "A continuacion encontrara la rubrica de evaluacion para solicitar el concepto a \"ENFERMERAS Y PERSONAL NO MEDICO\" sobre el comportamiento del residente en su sitio de trabajo. Por favor lea el item, luego senale el grado de desarrollo en que se encuentra el residente"),
                _item(context, "Concepto Enfermeria 2",
                    "A continuacion encontrara la rubrica de evaluacion para solicitar el concepto a \"ENFERMERAS Y PERSONAL NO MEDICO\" sobre el comportamiento del residente en su sitio de trabajo. Por favor lea el item, luego senale el grado de desarrollo en que se encuentra el residente"),
                _item(context, "Desempeño general de la rotación EV1",
                    "Le pedimos el ffavor lea el item y lo compare con la definicion de logro maximo a alcanzar (5), luego senale el grado de desarrollo en el que usted considera se encuentra el residente"),
                _item(context, "Revista Observada EV1",
                    "Rubrica de valoracion del desempeno en la atencion del paciente (REVISTA MEDICA)"),
                _item(context, "Revista Observada EV2",
                    "Rubrica de valoracion del desempeno en la atencion del paciente (REVISTA MEDICA)"),
                _item(context, "Mini CEX", "MiniCEX completo")
              ],
            )),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _item(context, nombre_rubrica, descripcion) {
    return Card(
      child: ExpansionTile(
        title: Text(nombre_rubrica),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Column(
              children: [
                Text(descripcion),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/rubrica');
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
