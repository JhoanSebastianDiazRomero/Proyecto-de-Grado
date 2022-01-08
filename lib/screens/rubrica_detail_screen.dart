// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:tesis/logic/bloc/rubrica_bloc.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricaScreen extends StatelessWidget {
  final Rubrica rubrica;

  RubricaScreen({Key? key, required this.rubrica}) : super(key: key);

  var estudiantes = List<Estudiante>.from([
    Estudiante('Jhoan Sebastian Diaz Romero', '1'),
    Estudiante('Juan Pablo Sanmiguel Mateus', '2'),
    Estudiante('Juan Ardila Silva', '3'),
    Estudiante('Ana María Mejía Mosquera', '4')
  ]);

  var procedimientos = List<PItem>.from([
    PItem(codigo: '1', nombre: 'revision'),
    PItem(codigo: '2', nombre: 'diagnostico'),
    PItem(codigo: '3', nombre: 'limpieza'),
    PItem(codigo: '4', nombre: 'cirugia'),
    PItem(codigo: '5', nombre: 'operacion'),
    PItem(codigo: '6', nombre: 'revision2'),
    PItem(codigo: '7', nombre: 'diagnostico2'),
    PItem(codigo: '8', nombre: 'limpieza2'),
    PItem(codigo: '9', nombre: 'cirugia2'),
    PItem(codigo: '10', nombre: 'operacion2'),
  ]);

  var patologias = List<PItem>.from([
    PItem(codigo: '1', nombre: 'otitis'),
    PItem(codigo: '2', nombre: 'dermatitis'),
    PItem(codigo: '3', nombre: 'fractura'),
    PItem(codigo: '4', nombre: 'covid'),
    PItem(codigo: '5', nombre: 'hepatitis'),
    PItem(codigo: '6', nombre: 'alergia'),
    PItem(codigo: '7', nombre: 'otitis2'),
    PItem(codigo: '8', nombre: 'dermatitis2'),
    PItem(codigo: '9', nombre: 'fractura2'),
    PItem(codigo: '10', nombre: 'covid2'),
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
      create: (context) => RubricaBloc()..add(LoadScreen(rubrica: rubrica)),
      child: BlocBuilder<RubricaBloc, RubricaState>(
        builder: (context, state) {
          if ((state.rubrica.criterios.isNotEmpty)) {
            return SafeArea(
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
                            controlsBuilder: (BuildContext context,
                                ControlsDetails controls) {
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
            );
          } else {
            return CircularProgressIndicator(value: null);
          }
        },
      ),
    );
  }

  List<Step> getSteps(BuildContext context, RubricaState state) => [
        Step(
            title: Text('Criterio 1'),
            content: _criterio(
                0,
                "Hace una historia clínica completa y detallada del paciente pediátrico. Identifica y prioriza los diagnósticos diferenciales, conoce y usa adecuadamente las pruebas diagnosticas indicadas.",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 0),
        Step(
            title: Text('Criterio 2'),
            content: _criterio(
                1,
                "Toma valores antropométricos, analiza percentil; valora el estado nutricional, la alimentación, salud bucal los hábitos y practica, hace evaluación ocular,  auditiva, identificación sexual, . ",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 1),
        Step(
            title: Text('Criterio 3'),
            content: _criterio(
                2,
                "Evalúa la conformación y dinámica familiar, situaciones de vulnerabilidad. Busca e identifica señales de stress, ansiedad, depresión, riesgo de violencia, maltrato, uso de tabaco, sustancias sicoactivas.  Maneja situaciones de riesgo, educa, remite para apoyar.",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 2),
        Step(
            title: Text('Criterio 4'),
            content: _criterio(
                3,
                "El residente demuestra capacidad para diagnosticar y manejar  adecuadamente las enfermedades y situaciones clínicas frecuentes de la rotación.  Reconoce sus limitaciones y solicita ayuda. ",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 3),
        Step(
            title: Text('Criterio 5'),
            content: _criterio(
                4,
                "Se comunica adecuadamente con el paciente y familia, educa y orienta sobre el cuidado, crianza, recreación, actividad física, alimentación, salud oral, sexualidad, vacunación, etc.",
                items,
                '',
                context,
                state),
            isActive: state.currentStep >= 4),
        Step(
            title: Text('Criterio 6'),
            content: _criterio(
                5,
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

  Widget _criterio(
      int numCriterio,
      String descripcion,
      List<CriterioItem> items,
      String comentario,
      BuildContext context,
      RubricaState state) {
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
                  numCriterio, index, actual.titulo, actual.descripcion);
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
            child: BlocBuilder<RubricaBloc, RubricaState>(
              builder: (context, state) {
                return TextFormField(
                  initialValue:
                      state.rubrica.criterios.elementAt(numCriterio).comentario,
                  onChanged: (text) {
                    context.read<RubricaBloc>().add(ComentarioCriterioChanged(
                        numCriterio: numCriterio, comentario: text));
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  scrollController: ScrollController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _criterioItem(
      int numCriterio, int value, String titulo, String descripcion) {
    if (descripcion.isEmpty) {
      return BlocBuilder<RubricaBloc, RubricaState>(
        builder: (context, state) {
          return RadioListTile(
              title: Text(titulo),
              dense: true,
              value: value,
              groupValue: state.rubrica.criterios
                  .elementAt(numCriterio)
                  .itemSeleccionado,
              onChanged: (pValue) {
                context.read<RubricaBloc>().add(ItemSeleccionadoChanged(
                    itemSeleccionado: pValue as int, numCriterio: numCriterio));
              });
        },
      );
    } else {
      return BlocBuilder<RubricaBloc, RubricaState>(
        builder: (context, state) {
          return RadioListTile(
              title: Text(titulo),
              subtitle: Text(descripcion),
              dense: true,
              value: value,
              groupValue: state.rubrica.criterios
                  .elementAt(numCriterio)
                  .itemSeleccionado,
              onChanged: (pValue) {
                context.read<RubricaBloc>().add(ItemSeleccionadoChanged(
                    itemSeleccionado: pValue as int, numCriterio: numCriterio));
              });
        },
      );
    }
  }

  Widget _procedimientos() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: 'Buscar procedimientos',
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          constraints: BoxConstraints(maxHeight: 500),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: procedimientos.length,
            itemBuilder: (context, index) {
              PItem actual = procedimientos.elementAt(index);
              return BlocBuilder<RubricaBloc, RubricaState>(
                builder: (context, state) {
                  return CheckboxListTile(
                      title: Text(actual.codigo + ' - ' + actual.nombre),
                      value: state.rubrica.procedimientosSeleccionados
                          .contains(actual.codigo),
                      onChanged: (bool? value) {
                        if (value != null && value) {
                          if (!state.rubrica.procedimientosSeleccionados
                              .contains(actual.codigo)) {
                            print("Checked");
                            context.read<RubricaBloc>().add(
                                ProcedimientoChecked(codigo: actual.codigo));
                          }
                        } else if (value != null && !value) {
                          if (state.rubrica.procedimientosSeleccionados
                              .contains(actual.codigo)) {
                            print("Unchecked");
                            context.read<RubricaBloc>().add(
                                ProcedimientoUnchecked(codigo: actual.codigo));
                          }
                        }
                      });
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget _patologias() {
    TextEditingController controller = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: 'Buscar patologias',
          ),
          onChanged: (text) {},
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          constraints: BoxConstraints(maxHeight: 500),
          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: patologias.length,
            itemBuilder: (context, index) {
              PItem actual = patologias.elementAt(index);
              return BlocBuilder<RubricaBloc, RubricaState>(
                builder: (context, state) {
                  return CheckboxListTile(
                      title: Text(actual.codigo + ' - ' + actual.nombre),
                      value: state.rubrica.patologiasSeleccionadas
                          .contains(actual.codigo),
                      onChanged: (bool? value) {
                        if (value != null && value) {
                          if (!state.rubrica.patologiasSeleccionadas
                              .contains(actual.codigo)) {
                            print("Checked");
                            context
                                .read<RubricaBloc>()
                                .add(PatologiaChecked(codigo: actual.codigo));
                          }
                        } else if (value != null && !value) {
                          if (state.rubrica.patologiasSeleccionadas
                              .contains(actual.codigo)) {
                            print("Unchecked");
                            context
                                .read<RubricaBloc>()
                                .add(PatologiaUnchecked(codigo: actual.codigo));
                          }
                        }
                      });
                },
              );
            },
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
            child: /* TextField(
              expands: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              scrollController: ScrollController(),
            ), */
                BlocBuilder<RubricaBloc, RubricaState>(
              builder: (context, state) {
                return TextFormField(
                  expands: true,
                  initialValue: state.rubrica.comentarioGeneral,
                  onChanged: (text) {
                    context
                        .read<RubricaBloc>()
                        .add(ComentarioGeneralChanged(comentario: text));
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  scrollController: ScrollController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                );
              },
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
}
