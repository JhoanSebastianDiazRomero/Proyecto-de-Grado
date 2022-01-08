import 'package:flutter/material.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:tesis/screens/rubrica_detail_screen.dart';

class CalificarRubricaScreen extends StatelessWidget {
  const CalificarRubricaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = List<CriterioItem>.from([
      CriterioItem('No lo observó', ''),
      CriterioItem('No lo hace', ''),
      CriterioItem('No está preparado',
          'Información es  insuficiente, omite datos relevantes o se desvía del problema.  El examen es incompleto u omite  detalles relevantes.'),
      CriterioItem('Aceptable',
          'La  información es completa y estructurada. Conoce e interpreta las pruebas diagnosticas esenciales.  Tiene en cuenta riesgos, beneficios y las preferencias del paciente.'),
      CriterioItem('Lo hace bien', ''),
      CriterioItem('Ejemplar',
          'La  información es completa, cronológica y estructurada, describe el estado del paciente y los hallazgos principales, hace un plan de estudio razonado, coherente. Conoce, prioriza e interpreta las pruebas diagnosticas,  las usa para el diagnostico, gravedad y seguimiento. Tiene en cuenta riesgos, beneficios y las preferencias del paciente.'),
      CriterioItem('No Aplica', '')
    ]);

    var criterios = List<Criterio>.from([
      Criterio(
          descripcion:
              'Hace una historia clínica completa y detallada del paciente pediátrico. Identifica y prioriza los diagnósticos diferenciales, conoce y usa adecuadamente las pruebas diagnosticas indicadas.',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'Toma valores antropométricos, analiza percentil; valora el estado nutricional, la alimentación, salud bucal los hábitos y practica, hace evaluación ocular,  auditiva, identificación sexual, . ',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'Toma valores antropométricos, analiza percentil; valora el estado nutricional, la alimentación, salud bucal los hábitos y practica, hace evaluación ocular,  auditiva, identificación sexual, . ',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'Evalúa la conformación y dinámica familiar, situaciones de vulnerabilidad. Busca e identifica señales de stress, ansiedad, depresión, riesgo de violencia, maltrato, uso de tabaco, sustancias sicoactivas.  Maneja situaciones de riesgo, educa, remite para apoyar.',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'Evalúa la conformación y dinámica familiar, situaciones de vulnerabilidad. Busca e identifica señales de stress, ansiedad, depresión, riesgo de violencia, maltrato, uso de tabaco, sustancias sicoactivas.  Maneja situaciones de riesgo, educa, remite para apoyar.',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'El residente demuestra capacidad para diagnosticar y manejar  adecuadamente las enfermedades y situaciones clínicas frecuentes de la rotación.  Reconoce sus limitaciones y solicita ayuda.',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'Se comunica adecuadamente con el paciente y familia, educa y orienta sobre el cuidado, crianza, recreación, actividad física, alimentación, salud oral, sexualidad, vacunación, etc.',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'Se comunica adecuadamente con el paciente y familia, educa y orienta sobre el cuidado, crianza, recreación, actividad física, alimentación, salud oral, sexualidad, vacunación, etc.',
          items: items,
          comentario: ''),
      Criterio(
          descripcion:
              'El residente  es  compasivo, se preocupa por  la privacidad  y autonomía del  paciente  y su familia ',
          items: items,
          comentario: '')
    ]);

    var rubricas = List<Rubrica>.from([
      Rubrica(
          nombre: 'Consulta Observada',
          descripcion:
              'Desempeno del residente en rotacion de consulta externa',
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: ''),
      Rubrica(
          nombre: 'Concepto Enfermeria',
          descripcion:
              'A continuacion encontrara la rubrica de evaluacion para solicitar el concepto a \"ENFERMERAS Y PERSONAL NO MEDICO\" sobre el comportamiento del residente en su sitio de trabajo. Por favor lea el item, luego senale el grado de desarrollo en que se encuentra el residente',
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: ''),
      Rubrica(
          nombre: 'Concepto Enfermeria 2',
          descripcion:
              'A continuacion encontrara la rubrica de evaluacion para solicitar el concepto a \"ENFERMERAS Y PERSONAL NO MEDICO\" sobre el comportamiento del residente en su sitio de trabajo. Por favor lea el item, luego senale el grado de desarrollo en que se encuentra el residente',
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: ''),
      Rubrica(
          nombre: 'Desempeño general de la rotación EV1',
          descripcion:
              "Le pedimos el ffavor lea el item y lo compare con la definicion de logro maximo a alcanzar (5), luego senale el grado de desarrollo en el que usted considera se encuentra el residente",
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: ''),
      Rubrica(
          nombre: 'Revista Observada EV1',
          descripcion:
              'Rubrica de valoracion del desempeno en la atencion del paciente (REVISTA MEDICA)',
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: ''),
      Rubrica(
          nombre: 'Revista Observada EV2',
          descripcion:
              'Rubrica de valoracion del desempeno en la atencion del paciente (REVISTA MEDICA)',
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: ''),
      Rubrica(
          nombre: "Mini CEX",
          descripcion: "MiniCEX completo",
          criterios: criterios,
          tieneProcedimientos: true,
          procedimientosSeleccionados: List<String>.empty(),
          tienePatologias: true,
          patologiasSeleccionadas: List<String>.empty(),
          comentarioGeneral: '')
    ]);

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
                    itemCount: rubricas.length,
                    itemBuilder: (context, index) {
                      return _item(context, rubricas.elementAt(index));
                    })),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }

  Widget _item(context, rubrica) {
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
                      final page = RubricaScreen(rubrica: rubrica);
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
