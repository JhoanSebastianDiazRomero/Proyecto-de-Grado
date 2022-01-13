import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tesis/logic/models/estado_criterio.dart';
import 'package:tesis/logic/models/estado_rubrica.dart';
import 'package:tesis/logic/models/models.dart';
import 'package:collection/collection.dart';
import 'package:tesis/api_client.dart';

part 'rubrica_event.dart';
part 'rubrica_state.dart';

class RubricaBloc extends Bloc<RubricaEvent, RubricaState> {
  RubricaBloc() : super(RubricaStateInitial());

  late List<PItem> procedimientos;
  late List<PItem> patologias;
  ApiClient apiClient = ApiClient();

  @override
  Stream<RubricaState> mapEventToState(RubricaEvent event) async* {
    if (event is LoadScreen) {
      Curso curso = event.curso;
      procedimientos = await apiClient.getProcedimientos();
      patologias = await apiClient.getPatologias();

      Estudiante primerEstudiante = curso.estudiantes.elementAt(0);
      Rubrica rubrica = curso.rubricas
          .firstWhere((rubrica) => rubrica.id == event.rubricaEscogida);
      Map<String, EstadoCriterio> estadoCriterios = {};
      for (var criterio in rubrica.criterios) {
        estadoCriterios[criterio.id] = EstadoCriterio();
      }
      yield state.copyWith(
          curso: curso,
          estudiantes: curso.estudiantes,
          rubrica: rubrica,
          estudianteSeleccionado: primerEstudiante,
          estadoRubrica: primerEstudiante.estadosRubricas.firstWhereOrNull(
                  (estadoRubrica) => estadoRubrica.idRubrica == rubrica.id) ??
              EstadoRubrica(
                  idRubrica: rubrica.id,
                  codigoEstudiante: primerEstudiante.codigo,
                  estadosCriterios: estadoCriterios),
          procedimientos: procedimientos,
          procedimientosFiltrados: procedimientos,
          patologias: patologias,
          patologiasFiltradas: patologias,
          terminoCarga: true);
    } else if (event is StepChanged) {
      yield _stepChanged(event);
    } else if (event is EstudianteSeleccionadoChanged) {
      yield _estudianteSeleccionadoProcess(event);
    } else if (event is ItemSeleccionadoChanged) {
      yield _itemSeleccionadoProcess(event);
    } else if (event is ComentarioCriterioChanged) {
      yield _comentarioChangedProcess(event);
    } else if (event is ScreenLoaded) {
      yield state.copyWith(terminoCarga: event.terminoCarga);
    } else if (event is ProcedimientoChecked) {
      yield _procedimientoCheckedProcess(event);
    } else if (event is ProcedimientoUnchecked) {
      yield _procedimientoUncheckedProcess(event);
    } else if (event is PatologiaChecked) {
      yield _patologiaCheckedProcess(event);
    } else if (event is PatologiaUnchecked) {
      yield _patologiaUncheckedProcess(event);
    } else if (event is FiltrarPatologias) {
      yield state.copyWith(patologiasFiltradas: event.patologiasFiltradas);
    } else if (event is FiltrarProcedimientos) {
      yield state.copyWith(
          procedimientosFiltrados: event.procedimientosFiltrados);
    } else if (event is ComentarioGeneralChanged) {
      yield _comentarioGeneralChangedProcess(event);
    }
  }

  RubricaState _estudianteSeleccionadoProcess(
      EstudianteSeleccionadoChanged event) {
    Curso curso = actualizarCurso(event);
    Map<String, EstadoCriterio> estadosCriterios = {};
    for (var criterio in state.rubrica.criterios) {
      estadosCriterios[criterio.id] = EstadoCriterio();
    }

    EstadoRubrica estadoRubrica = curso.estudiantes
            .firstWhere(
                (estudiante) => estudiante == event.estudianteSeleccionado)
            .estadosRubricas
            .firstWhereOrNull((estadoRubrica) =>
                estadoRubrica.idRubrica == state.rubrica.id) ??
        EstadoRubrica(
            idRubrica: state.rubrica.id,
            codigoEstudiante: event.estudianteSeleccionado.codigo,
            estadosCriterios: estadosCriterios);
    return state.copyWith(
        curso: curso,
        estudianteSeleccionado: event.estudianteSeleccionado,
        estadoRubrica: estadoRubrica,
        procedimientosFiltrados: procedimientos,
        patologiasFiltradas: patologias,
        currentStep: 0);
  }

  RubricaState _stepChanged(StepChanged event) {
    Curso curso = actualizarCurso(event);
    return state.copyWith(currentStep: event.currentStep, curso: curso);
  }

  Curso actualizarCurso(event) {
    Estudiante estudianteSeleccionado = state.estudianteSeleccionado;
    List<EstadoRubrica> estadosRubricas =
        estudianteSeleccionado.estadosRubricas;

    if (estadosRubricas.firstWhereOrNull(
            (estadoRubrica) => estadoRubrica.idRubrica == state.rubrica.id) !=
        null) {
      estadosRubricas[estadosRubricas.indexOf(estadosRubricas.firstWhere(
              (estadoRubrica) =>
                  estadoRubrica.idRubrica == state.rubrica.id))] =
          state.estadoRubrica;
    } else {
      estadosRubricas = [...estadosRubricas, state.estadoRubrica];
    }

    List<Estudiante> estudiantes = state.estudiantes;
    estudiantes[estudiantes.indexOf(state.estudianteSeleccionado)]
        .estadosRubricas = estadosRubricas;
    estudiantes[estudiantes.indexOf(state.estudianteSeleccionado)] =
        estudianteSeleccionado;

    Curso curso = state.curso.copyWith(estudiantes: estudiantes);
    apiClient.postCurso(curso);
    return curso;
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
    List<PItem> procedimientos = [
      ...state.estadoRubrica.procedimientosSeleccionados
    ];
    procedimientos.add(event.item);

    return state.copyWith(
        estadoRubrica: state.estadoRubrica
            .copyWith(procedimientosSeleccionados: procedimientos));
  }

  RubricaState _procedimientoUncheckedProcess(ProcedimientoUnchecked event) {
    List<PItem> procedimientos = [
      ...state.estadoRubrica.procedimientosSeleccionados
    ];
    procedimientos.remove(event.item);

    return state.copyWith(
        estadoRubrica: state.estadoRubrica
            .copyWith(procedimientosSeleccionados: procedimientos));
  }

  RubricaState _patologiaCheckedProcess(PatologiaChecked event) {
    List<PItem> patologias = [...state.estadoRubrica.patologiasSeleccionadas];
    patologias.add(event.item);
    return state.copyWith(
        estadoRubrica:
            state.estadoRubrica.copyWith(patologiasSeleccionadas: patologias));
  }

  RubricaState _patologiaUncheckedProcess(PatologiaUnchecked event) {
    List<PItem> patologias = [...state.estadoRubrica.patologiasSeleccionadas];
    patologias.remove(event.item);

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
