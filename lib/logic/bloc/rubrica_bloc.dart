import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/logic/models/estado_criterio.dart';
import 'package:tesis/logic/models/estado_rubrica.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:collection/collection.dart';

part 'rubrica_event.dart';
part 'rubrica_state.dart';

class RubricaBloc extends Bloc<RubricaEvent, RubricaState> {
  RubricaBloc() : super(RubricaStateInitial()) {
    on<LoadScreen>((event, emit) => emit(_loadScreen(event)));

    on<StepChanged>(
        (event, emit) => emit(state.copyWith(currentStep: event.currentStep)));

    on<EstudianteSeleccionadoChanged>((event, emit) => emit(
        state.copyWith(estudianteSeleccionado: event.estudianteSeleccionado)));

    on<ItemSeleccionadoChanged>(
        (event, emit) => {emit(_itemSeleccionadoProcess(event))});

    on<ComentarioCriterioChanged>(
        (event, emit) => emit(_comentarioChangedProcess(event)));

    on<ScreenLoaded>((event, emit) =>
        emit(state.copyWith(terminoCarga: event.terminoCarga)));

    on<ProcedimientoChecked>(
        (event, emit) => emit(_procedimientoCheckedProcess(event)));

    on<ProcedimientoUnchecked>(
        (event, emit) => emit(_procedimientoUncheckedProcess(event)));

    on<PatologiaChecked>(
        (event, emit) => emit(_patologiaCheckedProcess(event)));

    on<PatologiaUnchecked>(
        (event, emit) => emit(_patologiaUncheckedProcess(event)));

    on<FiltrarPatologias>((event, emit) =>
        emit(state.copyWith(patologiasFiltradas: event.patologiasFiltradas)));

    on<FiltrarProcedimientos>((event, emit) => emit(state.copyWith(
        procedimientosFiltrados: event.procedimientosFiltrados)));

    on<ComentarioGeneralChanged>(
        (event, emit) => emit(_comentarioGeneralChangedProcess(event)));
  }

  RubricaState _loadScreen(LoadScreen event) {
    Estudiante primerEstudiante = event.estudiantes.elementAt(0);
    Rubrica rubrica = event.rubrica;
    Map<String, EstadoCriterio> estadoCriterios = {};

    for (var criterio in rubrica.criterios) {
      estadoCriterios[criterio.id] = EstadoCriterio();
    }

    //Carga steps
    List<Step> steps = [];

    return state.copyWith(
        estudiantes: event.estudiantes,
        rubrica: rubrica,
        estudianteSeleccionado: primerEstudiante,
        estadoRubrica: primerEstudiante.estadosRubricas.firstWhereOrNull(
                (estadoRubrica) => estadoRubrica.idRubrica == rubrica.id) ??
            EstadoRubrica(
                idRubrica: rubrica.id,
                codigoEstudiante: primerEstudiante.codigo,
                estadosCriterios: estadoCriterios),
        procedimientosFiltrados: event.procedimientos,
        patologiasFiltradas: event.patologias);
  }

  RubricaState _itemSeleccionadoProcess(ItemSeleccionadoChanged event) {
    Map<String, EstadoCriterio> estadosCriterios =
        state.estadoRubrica.estadosCriterios;

    estadosCriterios[event.idCriterio] = estadosCriterios[event.idCriterio]!
        .copyWith(itemSeleccionado: event.itemSeleccionado);

    return state.copyWith(
        estadoRubrica:
            state.estadoRubrica.copyWith(estadosCriterios: estadosCriterios));
  }

  RubricaState _comentarioChangedProcess(ComentarioCriterioChanged event) {
    Map<String, EstadoCriterio> estadosCriterios =
        state.estadoRubrica.estadosCriterios;

    estadosCriterios[event.idCriterio] = estadosCriterios[event.idCriterio]!
        .copyWith(comentario: event.comentario);

    return state.copyWith(
        estadoRubrica:
            state.estadoRubrica.copyWith(estadosCriterios: estadosCriterios));
  }

  RubricaState _procedimientoCheckedProcess(ProcedimientoChecked event) {
    List<String> procedimientos = [
      ...state.estadoRubrica.procedimientosSeleccionados
    ];
    procedimientos.add(event.codigo);
    return state.copyWith(
        estadoRubrica: state.estadoRubrica
            .copyWith(procedimientosSeleccionados: procedimientos));
  }

  RubricaState _procedimientoUncheckedProcess(ProcedimientoUnchecked event) {
    List<String> procedimientos = [
      ...state.estadoRubrica.procedimientosSeleccionados
    ];
    procedimientos.remove(event.codigo);

    return state.copyWith(
        estadoRubrica: state.estadoRubrica
            .copyWith(procedimientosSeleccionados: procedimientos));
  }

  RubricaState _patologiaCheckedProcess(PatologiaChecked event) {
    List<String> patologias = [...state.estadoRubrica.patologiasSeleccionadas];
    patologias.add(event.codigo);
    return state.copyWith(
        estadoRubrica:
            state.estadoRubrica.copyWith(patologiasSeleccionadas: patologias));
  }

  RubricaState _patologiaUncheckedProcess(PatologiaUnchecked event) {
    List<String> patologias = [...state.estadoRubrica.patologiasSeleccionadas];
    patologias.remove(event.codigo);

    return state.copyWith(
        estadoRubrica:
            state.estadoRubrica.copyWith(patologiasSeleccionadas: patologias));
  }

  RubricaState _comentarioGeneralChangedProcess(
      ComentarioGeneralChanged event) {
    return state.copyWith(
        estadoRubrica:
            state.estadoRubrica.copyWith(comentarioGeneral: event.comentario));
  }
}
