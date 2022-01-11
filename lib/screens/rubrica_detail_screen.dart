// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:tesis/logic/bloc/rubrica_bloc.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricaScreen extends StatelessWidget {
  final Rubrica rubrica;
  final List<Estudiante> estudiantes;

  RubricaScreen({Key? key, required this.rubrica, required this.estudiantes})
      : super(key: key);

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
      create: (context) => RubricaBloc()
        ..add(LoadScreen(
            estudiantes: estudiantes,
            rubrica: rubrica,
            procedimientos: procedimientos,
            patologias: patologias)),
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

  List<Step> getSteps(BuildContext context, RubricaState state) {
    List<Step> steps = [];
    List<Criterio> criterios = state.rubrica.criterios;

    int stepNumber = 0;
    for (int i = 0; i < criterios.length; i++) {
      Criterio actual = criterios.elementAt(i);
      steps = [
        ...steps,
        Step(
            title: Text('Criterio ' + (i + 1).toString()),
            content: _criterio(actual.id, actual.descripcion, actual.items, '',
                context, state),
            isActive: state.currentStep >= stepNumber)
      ];
      stepNumber++;
    }

    if (state.rubrica.tieneProcedimientos) {
      steps = [
        ...steps,
        Step(
            title: Text('Procedimientos'),
            content: _procedimientos(),
            isActive: state.currentStep >= stepNumber)
      ];
      stepNumber++;
    }

    if (state.rubrica.tieneProcedimientos) {
      steps = [
        ...steps,
        Step(
            title: Text('Patologias'),
            content: _patologias(),
            isActive: state.currentStep >= stepNumber)
      ];
      stepNumber++;
    }

    steps = [
      ...steps,
      Step(
          title: Text('Comentario general'),
          content: _comentarioGeneral(context),
          isActive: state.currentStep >= stepNumber)
    ];

    return steps;
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
              value: state.estudianteSeleccionado,
              icon: const Icon(Icons.expand_more_rounded),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Color(0xFF1C958E),
              ),
              onChanged: (Estudiante? newValue) {
                context.read<RubricaBloc>().add(EstudianteSeleccionadoChanged(
                    estudianteSeleccionado: newValue!));
              },
              items: estudiantes
                  .map<DropdownMenuItem<Estudiante>>((Estudiante estudiante) {
                return DropdownMenuItem<Estudiante>(
                  value: estudiante,
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
          backgroundImage: NetworkImage(state.estudianteSeleccionado.urlImagen),
          backgroundColor: Colors.transparent,
        )
      ],
    ));
  }

  Widget _criterio(
      String idCriterio,
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
                  idCriterio, index, actual.titulo, actual.descripcion);
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
                  initialValue: state
                      .estadoRubrica.estadosCriterios[idCriterio]!.comentario,
                  onChanged: (text) {
                    context.read<RubricaBloc>().add(ComentarioCriterioChanged(
                        idCriterio: idCriterio, comentario: text));
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
      String idCriterio, int value, String titulo, String descripcion) {
    if (descripcion.isEmpty) {
      return BlocBuilder<RubricaBloc, RubricaState>(
        builder: (context, state) {
          return RadioListTile(
              title: Text(titulo),
              dense: true,
              value: value,
              groupValue: state
                  .estadoRubrica.estadosCriterios[idCriterio]!.itemSeleccionado,
              onChanged: (pValue) {
                context.read<RubricaBloc>().add(ItemSeleccionadoChanged(
                    itemSeleccionado: pValue as int, idCriterio: idCriterio));
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
              groupValue: state
                  .estadoRubrica.estadosCriterios[idCriterio]!.itemSeleccionado,
              onChanged: (pValue) {
                context.read<RubricaBloc>().add(ItemSeleccionadoChanged(
                    itemSeleccionado: pValue as int, idCriterio: idCriterio));
              });
        },
      );
    }
  }

  Widget _procedimientos() {
    return BlocBuilder<RubricaBloc, RubricaState>(
      builder: (context, state) {
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
              onChanged: (query) {
                filtrarProcedimientos(query, context, state);
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              constraints: BoxConstraints(maxHeight: 500),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: state.procedimientosFiltrados.length,
                itemBuilder: (context, index) {
                  PItem actual = state.procedimientosFiltrados.elementAt(index);
                  return CheckboxListTile(
                      title: Text(actual.toString()),
                      value: state.estadoRubrica.procedimientosSeleccionados
                          .contains(actual.codigo),
                      onChanged: (bool? value) {
                        if (value != null && value) {
                          if (!state.estadoRubrica.procedimientosSeleccionados
                              .contains(actual.codigo)) {
                            print("Checked");
                            context.read<RubricaBloc>().add(
                                ProcedimientoChecked(codigo: actual.codigo));
                          }
                        } else if (value != null && !value) {
                          if (state.estadoRubrica.procedimientosSeleccionados
                              .contains(actual.codigo)) {
                            print("Unchecked");
                            context.read<RubricaBloc>().add(
                                ProcedimientoUnchecked(codigo: actual.codigo));
                          }
                        }
                      });
                },
              ),
            )
          ],
        );
      },
    );
  }

  Widget _patologias() {
    return BlocBuilder<RubricaBloc, RubricaState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Buscar patologias',
              ),
              onChanged: (query) {
                filtrarPatologias(query, context, state);
              },
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              constraints: BoxConstraints(maxHeight: 500),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: state.patologiasFiltradas.length,
                itemBuilder: (context, index) {
                  PItem actual = state.patologiasFiltradas.elementAt(index);
                  return BlocBuilder<RubricaBloc, RubricaState>(
                    builder: (context, state) {
                      return CheckboxListTile(
                          title: Text(actual.codigo + ' - ' + actual.nombre),
                          value: state.estadoRubrica.patologiasSeleccionadas
                              .contains(actual.codigo),
                          onChanged: (bool? value) {
                            if (value != null && value) {
                              if (!state.estadoRubrica.patologiasSeleccionadas
                                  .contains(actual.codigo)) {
                                print("Checked");
                                context.read<RubricaBloc>().add(
                                    PatologiaChecked(codigo: actual.codigo));
                              }
                            } else if (value != null && !value) {
                              if (state.estadoRubrica.patologiasSeleccionadas
                                  .contains(actual.codigo)) {
                                print("Unchecked");
                                context.read<RubricaBloc>().add(
                                    PatologiaUnchecked(codigo: actual.codigo));
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
      },
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
            child: BlocBuilder<RubricaBloc, RubricaState>(
              builder: (context, state) {
                return TextFormField(
                  expands: true,
                  initialValue: state.estadoRubrica.comentarioGeneral,
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

  void filtrarProcedimientos(
      String query, BuildContext context, RubricaState state) {
    final procedimientosFiltrados = procedimientos.where((procedimiento) {
      final procedimientoLower = procedimiento.toString().toLowerCase();
      final queryLower = query.toLowerCase();
      return procedimientoLower.contains(queryLower);
    }).toList();

    context.read<RubricaBloc>().add(FiltrarProcedimientos(
        procedimientosFiltrados: procedimientosFiltrados));
  }

  void filtrarPatologias(
      String query, BuildContext context, RubricaState state) {
    final patologiasFiltradas = patologias.where((patologia) {
      final patologiaLower = patologia.toString().toLowerCase();
      final queryLower = query.toLowerCase();
      return patologiaLower.contains(queryLower);
    }).toList();

    context
        .read<RubricaBloc>()
        .add(FiltrarPatologias(patologiasFiltradas: patologiasFiltradas));
  }
}
