// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tesis/logic/bloc/rubrica_bloc.dart';
import 'package:tesis/logic/models/criterio.dart';
import 'package:tesis/logic/models/criterio_item.dart';
import 'package:tesis/logic/models/models.dart';
import '../logic/models/estudiante.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricaScreen extends StatelessWidget {
  final Rubrica rubrica;

  RubricaScreen({Key? key, required this.rubrica}) : super(key: key);

  var estudiantes = List<Estudiante>.from([
    Estudiante('Jhoan Sebastian Diaz Romero', '1'),
    Estudiante('Juan Pablo Sanmiguel Mateus', '2'),
    Estudiante('Juan Ardila Silva', '3'),
    Estudiante('Sofia Rojas Segura', '4')
  ]);

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RubricaBloc>(
      create: (context) => RubricaBloc(),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Revista Observada EV1"),
            ),
            body: ListView(
              children: [
                SizedBox(height: 20),
                BlocBuilder<RubricaBloc, RubricaState>(
                  builder: (context, state) {
                    return _EstudianteBox(estudiantes, context, state);
                  },
                ),
                SizedBox(height: 10),
                BlocBuilder<RubricaBloc, RubricaState>(
                  builder: (context, state) {
                    return Stepper(
                      controlsBuilder:
                          (BuildContext context, ControlsDetails controls) {
                        return Row(
                          children: <Widget>[],
                        );
                      },
                      type: StepperType.vertical,
                      physics: ClampingScrollPhysics(),
                      currentStep: state.currentStep,
                      onStepTapped: (step) => {
                        context
                            .read<RubricaBloc>()
                            .add(StepChanged(currentStep: step))
                      },
                      onStepContinue: () {},
                      onStepCancel: () {},
                      steps: getSteps(context, state),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }

  List<Step> getSteps(BuildContext context, RubricaState state) => [
        Step(
            title: Text('Criterio 1'),
            content: _criterio(
                "Hace una historia clínica completa y detallada del paciente pediátrico. Identifica y prioriza los diagnósticos diferenciales, conoce y usa adecuadamente las pruebas diagnosticas indicadas.",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 0),
        Step(
            title: Text('Criterio 2'),
            content: _criterio(
                "Toma valores antropométricos, analiza percentil; valora el estado nutricional, la alimentación, salud bucal los hábitos y practica, hace evaluación ocular,  auditiva, identificación sexual, . ",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 1),
        Step(
            title: Text('Criterio 3'),
            content: _criterio(
                "Evalúa la conformación y dinámica familiar, situaciones de vulnerabilidad. Busca e identifica señales de stress, ansiedad, depresión, riesgo de violencia, maltrato, uso de tabaco, sustancias sicoactivas.  Maneja situaciones de riesgo, educa, remite para apoyar.",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 2),
        Step(
            title: Text('Criterio 4'),
            content: _criterio(
                "El residente demuestra capacidad para diagnosticar y manejar  adecuadamente las enfermedades y situaciones clínicas frecuentes de la rotación.  Reconoce sus limitaciones y solicita ayuda. ",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 3),
        Step(
            title: Text('Criterio 5'),
            content: _criterio(
                "Se comunica adecuadamente con el paciente y familia, educa y orienta sobre el cuidado, crianza, recreación, actividad física, alimentación, salud oral, sexualidad, vacunación, etc.",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 4),
        Step(
            title: Text('Criterio 6'),
            content: _criterio(
                "El residente  es  compasivo, se preocupa por  la privacidad  y autonomía del  paciente  y su familia ",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 5),
        Step(
            title: Text('Procedimientos'),
            content: _procedimientos(),
            isActive: state.currentStep >= 6),
        Step(
            title: Text('Patologías'),
            content: _patologias(),
            isActive: state.currentStep >= 7),
        Step(
            title: Text('Comentario General'),
            content: _comentarioGeneral(context),
            isActive: state.currentStep >= 8),
      ];

  /* List<Step> getSteps(context) {
    List<Step> steps = List<Step>.empty();
    List<Criterio> criterios = rubrica.criterios;
    int stepNumber = 0;

    for (int i = 0; i < criterios.length; i++) {
      stepNumber++;
      Criterio actual = criterios.elementAt(i);
      steps.add(
        Step(
            title: Text('Criterio ' + (i + 1).toString()),
            content:
                _criterio(actual.descripcion, actual.items, actual.comentario),
            isActive: currentStep == stepNumber),
      );
    }

    if (rubrica.tieneProcedimientos) {
      stepNumber++;
      steps.add(
        Step(
            title: Text('Procedimientos'),
            content: _procedimientos(),
            isActive: currentStep == stepNumber),
      );
    }

    if (rubrica.tienePatologias) {
      stepNumber++;
      steps.add(
        Step(
            title: Text('Patologias'),
            content: _patologias(),
            isActive: currentStep == stepNumber),
      );
    }

    stepNumber++;
    steps.add(
      Step(
          title: Text('Comentario General'),
          content: _comentarioGeneral(context),
          isActive: currentStep == stepNumber),
    );

    return steps;
  } */

  /* continued() {
    final isLastStep = currentStep == getSteps().length - 1;

    if (isLastStep) {
    } else {
      currentStep < 2 ? setState(() => currentStep += 1) : null;
    } 
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  } */

  Widget _criterio(String descripcion, List<CriterioItem> items,
      String comentario, BuildContext context, RubricaState state) {
    print('Estoy en criterio ' + (state.currentStep + 1).toString());
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: Column(
        children: [
          Text(descripcion),
          SizedBox(
            height: 10,
          ),
          Divider(),
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              CriterioItem actual = items.elementAt(index);
              return _criterioItem(
                  index, actual.titulo, actual.descripcion, context, state);
            },
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
              controller: TextEditingController(text: comentario),
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

  Widget _procedimientos() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Buscar procedimientos',
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
                    /* setState(() {
                      _isSelected[0] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 2"),
                  value: _isSelected[1],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[1] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 3"),
                  value: _isSelected[2],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[2] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 4"),
                  value: _isSelected[3],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[3] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 5"),
                  value: _isSelected[4],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[4] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 6"),
                  value: _isSelected[5],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[5] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 7"),
                  value: _isSelected[6],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[6] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 8"),
                  value: _isSelected[7],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[7] = true;
                    }); */
                  }),
            ],
          ),
        )
      ],
    );
  }

  Widget _patologias() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Buscar patologias',
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
                    /* setState(() {
                      _isSelected[0] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 2"),
                  value: _isSelected[1],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[1] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 3"),
                  value: _isSelected[2],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[2] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 4"),
                  value: _isSelected[3],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[3] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 5"),
                  value: _isSelected[4],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[4] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 6"),
                  value: _isSelected[5],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[5] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 7"),
                  value: _isSelected[6],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[6] = value;
                    }); */
                  }),
              CheckboxListTile(
                  title: Text("Elemento 8"),
                  value: _isSelected[7],
                  onChanged: (bool? value) {
                    /* setState(() {
                      _isSelected[7] = true;
                    }); */
                  }),
            ],
          ),
        )
      ],
    );
  }

  Widget _comentarioGeneral(context) {
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

  Widget _criterioItem(int value, String titulo, String descripcion,
      BuildContext context, RubricaState state) {
    if (descripcion.isEmpty) {
      return RadioListTile(
          title: Text(titulo),
          dense: true,
          value: value,
          groupValue: state.selectedRadioBtns[state.currentStep],
          onChanged: (pValue) {
            /* setState(() {
              _selectedRadioBtnsValue = pValue as int;
            }); */
            List<int> selectedRadioBtns = state.selectedRadioBtns;
            selectedRadioBtns[state.currentStep] = pValue as int;
            context.read<RubricaBloc>().add(
                SelectedRadioBtnsChanged(selectedRadioBtns: selectedRadioBtns));
          });
    } else {
      return RadioListTile(
          title: Text(titulo),
          subtitle: Text(descripcion),
          dense: true,
          value: value,
          groupValue: state.selectedRadioBtns[state.currentStep],
          onChanged: (pValue) {
            /* setState(() {
              _selectedRadioBtnsValue = pValue as int;
            }); */
            List<int> selectedRadioBtns = state.selectedRadioBtns;
            selectedRadioBtns[state.currentStep] = pValue as int;
            print(selectedRadioBtns);
            context.read<RubricaBloc>().add(
                SelectedRadioBtnsChanged(selectedRadioBtns: selectedRadioBtns));
          });
    }
  }

  Widget _EstudianteBox(
      List<Estudiante> estudiantes, BuildContext context, RubricaState state) {
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
              value: state.dropdownValue,
              icon: const Icon(Icons.expand_more_rounded),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Color(0xFF1C958E),
              ),
              onChanged: (String? newValue) {
                context
                    .read<RubricaBloc>()
                    .add(DropdownChanged(dropdownValue: newValue!));
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
