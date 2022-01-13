import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:tesis/logic/bloc/rubrica_bloc.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricaScreen extends StatelessWidget {
  final Curso curso;
  final String rubricaEscogida;

  RubricaScreen({Key? key, required this.curso, required this.rubricaEscogida})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RubricaBloc>(
      create: (context) => RubricaBloc()
        ..add(LoadScreen(curso: curso, rubricaEscogida: rubricaEscogida)),
      child: BlocBuilder<RubricaBloc, RubricaState>(
        builder: (context, state) {
          if ((state.terminoCarga)) {
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text("Revista Observada EV1"),
                  ),
                  body: ListView(
                    children: [
                      SizedBox(height: 20),
                      _EstudianteBox(curso.estudiantes, context, state),
                      SizedBox(height: 10),
                      Stepper(
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
                      )
                    ],
                  )),
            );
          } else {
            return Center(child: CircularProgressIndicator(value: null));
          }
        },
      ),
    );
  }

  List<Step> getSteps(BuildContext context, RubricaState state) {
    List<Step> steps = [];
    Rubrica rubrica = state.curso.rubricas
        .firstWhere((rubrica) => rubrica.id == rubricaEscogida);
    List<Criterio> criterios = rubrica.criterios;

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

    if (rubrica.tieneProcedimientos) {
      steps = [
        ...steps,
        Step(
            title: Text('Procedimientos'),
            content: _procedimientos(context, state),
            isActive: state.currentStep >= stepNumber)
      ];
      stepNumber++;
    }

    if (rubrica.tieneProcedimientos) {
      steps = [
        ...steps,
        Step(
            title: Text('Patologias'),
            content: _patologias(context, state),
            isActive: state.currentStep >= stepNumber)
      ];
      stepNumber++;
    }

    steps = [
      ...steps,
      Step(
          title: Text('Comentario general'),
          content: _comentarioGeneral(context, state),
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
                print(state.estudianteSeleccionado.urlImagen);
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
              return _criterioItem(idCriterio, index, actual.titulo,
                  actual.descripcion, context, state);
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
              child: TextFormField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: state
                        .estadoRubrica.estadosCriterios[idCriterio]!.comentario,
                    selection: TextSelection.collapsed(
                      offset: state.estadoRubrica.estadosCriterios[idCriterio]!
                          .comentario.length,
                    ),
                  ),
                ),
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
              ))
        ],
      ),
    );
  }

  Widget _criterioItem(String idCriterio, int value, String titulo,
      String descripcion, BuildContext context, RubricaState state) {
    if (descripcion.isEmpty) {
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
    } else {
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
    }
  }

  Widget _procedimientos(BuildContext context, RubricaState state) {
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
                      .contains(actual),
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      if (!state.estadoRubrica.procedimientosSeleccionados
                          .contains(actual)) {
                        context
                            .read<RubricaBloc>()
                            .add(ProcedimientoChecked(item: actual));
                      }
                    } else if (value != null && !value) {
                      if (state.estadoRubrica.procedimientosSeleccionados
                          .contains(actual)) {
                        context
                            .read<RubricaBloc>()
                            .add(ProcedimientoUnchecked(item: actual));
                      }
                    }
                  });
            },
          ),
        )
      ],
    );
  }

  Widget _patologias(BuildContext context, RubricaState state) {
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
              return CheckboxListTile(
                  title: Text(actual.toString()),
                  value: state.estadoRubrica.patologiasSeleccionadas
                      .contains(actual),
                  onChanged: (bool? value) {
                    if (value != null && value) {
                      if (!state.estadoRubrica.patologiasSeleccionadas
                          .contains(actual)) {
                        context
                            .read<RubricaBloc>()
                            .add(PatologiaChecked(item: actual));
                      }
                    } else if (value != null && !value) {
                      if (state.estadoRubrica.patologiasSeleccionadas
                          .contains(actual)) {
                        context
                            .read<RubricaBloc>()
                            .add(PatologiaUnchecked(item: actual));
                      }
                    }
                  });
            },
          ),
        )
      ],
    );
  }

  Widget _comentarioGeneral(BuildContext context, RubricaState state) {
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
              child: TextFormField(
                expands: true,
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: state.estadoRubrica.comentarioGeneral,
                    selection: TextSelection.collapsed(
                      offset: state.estadoRubrica.comentarioGeneral.length,
                    ),
                  ),
                ),
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
              )),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                print(jsonEncode(curso));
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
    final procedimientosFiltrados = state.procedimientos.where((procedimiento) {
      final procedimientoLower = procedimiento.toString().toLowerCase();
      final queryLower = query.toLowerCase();
      return procedimientoLower.contains(queryLower);
    }).toList();

    context.read<RubricaBloc>().add(FiltrarProcedimientos(
        procedimientosFiltrados: procedimientosFiltrados));
  }

  void filtrarPatologias(
      String query, BuildContext context, RubricaState state) {
    final patologiasFiltradas = state.patologias.where((patologia) {
      final patologiaLower = patologia.toString().toLowerCase();
      final queryLower = query.toLowerCase();
      return patologiaLower.contains(queryLower);
    }).toList();

    context
        .read<RubricaBloc>()
        .add(FiltrarPatologias(patologiasFiltradas: patologiasFiltradas));
  }
}
