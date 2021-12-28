// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tesis/logic/models/models.dart';
import '../logic/models/estudiante.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricaScreen extends StatefulWidget {
  final Rubrica rubrica;
  const RubricaScreen({Key? key, required this.rubrica}) : super(key: key);

  @override
  _RubricaScreenState createState() => _RubricaScreenState();
}

class _RubricaScreenState extends State<RubricaScreen> {
  var estudiantes = List<Estudiante>.from([
    Estudiante('Jhoan Sebastian Diaz Romero', '1'),
    Estudiante('Juan Pablo Sanmiguel Mateus', '2'),
    Estudiante('Juan Ardila Silva', '3'),
    Estudiante('Sofia Rojas Segura', '4')
  ]);

  //Stepper State
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  //Dropdown State
  String dropdownValue = 'Jhoan Sebastian Diaz Romero';

  //CriteriosState
  int _selectedRadioBtnsValue = -1;

  //CheckboxListState
  List<bool?> _isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Revista Observada EV1"),
          ),
          body: ListView(
            children: [
              SizedBox(height: 20),
              _EstudianteBox(estudiantes),
              SizedBox(height: 10),
              Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return Row(
                    children: <Widget>[],
                  );
                },
                type: stepperType,
                physics: ClampingScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: getSteps(),
              ),
            ],
          )),
    );
  }

  List<Step> getSteps() => [
        Step(
            title: Text('Criterio 1'),
            content: _basicStepContent(
                "Hace una historia clínica completa y detallada del paciente pediátrico. Identifica y prioriza los diagnósticos diferenciales, conoce y usa adecuadamente las pruebas diagnosticas indicadas."),
            isActive: _currentStep >= 0),
        Step(
            title: Text('Criterio 2'),
            content: _basicStepContent(
                "Toma valores antropométricos, analiza percentil; valora el estado nutricional, la alimentación, salud bucal los hábitos y practica, hace evaluación ocular,  auditiva, identificación sexual, . "),
            isActive: _currentStep >= 1),
        Step(
            title: Text('Criterio 3'),
            content: _basicStepContent(
                "Evalúa la conformación y dinámica familiar, situaciones de vulnerabilidad. Busca e identifica señales de stress, ansiedad, depresión, riesgo de violencia, maltrato, uso de tabaco, sustancias sicoactivas.  Maneja situaciones de riesgo, educa, remite para apoyar."),
            isActive: _currentStep >= 2),
        Step(
            title: Text('Criterio 4'),
            content: _basicStepContent(
                "El residente demuestra capacidad para diagnosticar y manejar  adecuadamente las enfermedades y situaciones clínicas frecuentes de la rotación.  Reconoce sus limitaciones y solicita ayuda. "),
            isActive: _currentStep >= 3),
        Step(
            title: Text('Criterio 5'),
            content: _basicStepContent(
                "Se comunica adecuadamente con el paciente y familia, educa y orienta sobre el cuidado, crianza, recreación, actividad física, alimentación, salud oral, sexualidad, vacunación, etc."),
            isActive: _currentStep >= 4),
        Step(
            title: Text('Criterio 6'),
            content: _basicStepContent(
                "El residente  es  compasivo, se preocupa por  la privacidad  y autonomía del  paciente  y su familia "),
            isActive: _currentStep >= 5),
        Step(
            title: Text('Procedimientos'),
            content: _specialStepContent('procedimiento'),
            isActive: _currentStep >= 6),
        Step(
            title: Text('Patologías'),
            content: _specialStepContent('patología'),
            isActive: _currentStep >= 7),
        Step(
            title: Text('Comentario General'),
            content: _comentarioStepContent(),
            isActive: _currentStep >= 7),
      ];

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    final isLastStep = _currentStep == getSteps().length - 1;

    if (isLastStep) {
    } else {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Widget _basicStepContent(descripcion) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: Column(
        children: [
          Text(descripcion),
          SizedBox(
            height: 10,
          ),
          Divider(),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              _criterioItem(0, "No lo observó", ""),
              _criterioItem(1, "No lo hace", ""),
              _criterioItem(2, "No está preparado",
                  "información es  insuficiente, omite datos relevantes o se desvía del problema.  El examen es incompleto u omite  detalles relevantes."),
              _criterioItem(3, "Aceptable",
                  "La  información es completa y estructurada. Conoce e interpreta las pruebas diagnosticas esenciales.  Tiene en cuenta riesgos, beneficios y las preferencias del paciente. "),
              _criterioItem(4, "Lo hace bien", ""),
              _criterioItem(5, "Ejemplar",
                  "La  información es completa, cronológica y estructurada, describe el estado del paciente y los hallazgos principales, hace un plan de estudio razonado, coherente. Conoce, prioriza e interpreta las pruebas diagnosticas,  las usa para el diagnostico, gravedad y seguimiento. Tiene en cuenta riesgos, beneficios y las preferencias del paciente."),
              _criterioItem(6, "No Aplica", ""),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Text("Comentario: "),
          Container(
            constraints: BoxConstraints(maxHeight: 100),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scrollController: ScrollController(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _specialStepContent(tipo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Buscar ' + tipo,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          constraints: BoxConstraints(maxHeight: 500),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              CheckboxListTile(
                  title: Text("Elemento 1"),
                  value: _isSelected[0],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[0] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 2"),
                  value: _isSelected[1],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[1] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 3"),
                  value: _isSelected[2],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[2] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 4"),
                  value: _isSelected[3],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[3] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 5"),
                  value: _isSelected[4],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[4] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 6"),
                  value: _isSelected[5],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[5] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 7"),
                  value: _isSelected[6],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[6] = value;
                    });
                  }),
              CheckboxListTile(
                  title: Text("Elemento 8"),
                  value: _isSelected[7],
                  onChanged: (bool? value) {
                    setState(() {
                      _isSelected[7] = true;
                    });
                  }),
            ],
          ),
        )
      ],
    );
  }

  Widget _comentarioStepContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
              'Si no desea hacer un comentario general, puede dejar este espacio en blanco'),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: TextField(
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scrollController: ScrollController(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Finalizar'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF1C958E),
              )),
        ],
      ),
    );
  }

  Widget _criterioItem(int value, titulo, descripcion) {
    if (descripcion.isEmpty) {
      return RadioListTile(
          title: Text(titulo),
          dense: true,
          value: value,
          groupValue: _selectedRadioBtnsValue,
          onChanged: (pValue) {
            setState(() {
              _selectedRadioBtnsValue = pValue as int;
            });
          });
    } else {
      return RadioListTile(
          title: Text(titulo),
          subtitle: Text(descripcion),
          dense: true,
          value: value,
          groupValue: _selectedRadioBtnsValue,
          onChanged: (pValue) {
            setState(() {
              _selectedRadioBtnsValue = pValue as int;
            });
          });
    }
  }

  Widget _EstudianteBox(List<Estudiante> estudiantes) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Estudiante",
                style: TextStyle(color: Color(0xFF1C958E), fontSize: 20)),
            DropdownButton(
              value: dropdownValue,
              icon: const Icon(Icons.expand_more_rounded),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Color(0xFF1C958E),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: estudiantes
                  .map<DropdownMenuItem<String>>((Estudiante estudiante) {
                return DropdownMenuItem<String>(
                  value: estudiante.nombre,
                  child: Text(estudiante.nombre),
                );
              }).toList(),
            ),
          ],
        ),
        SizedBox(
          width: 30,
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg"),
          backgroundColor: Colors.transparent,
        )
      ],
    ));
  }
}
