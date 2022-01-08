import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tesis/logic/models/models.dart';

part 'rubrica_event.dart';
part 'rubrica_state.dart';

class RubricaBloc extends Bloc<RubricaEvent, RubricaState> {
  RubricaBloc() : super(RubricaStateInitial()) {
    on<LoadScreen>(
        (event, emit) => emit(state.copyWith(rubrica: event.rubrica)));

    on<StepChanged>(
        (event, emit) => emit(state.copyWith(currentStep: event.currentStep)));

    on<DropdownChanged>((event, emit) =>
        emit(state.copyWith(dropdownValue: event.dropdownValue)));

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

    on<ComentarioGeneralChanged>(
        (event, emit) => emit(_comentarioGeneralChangedProcess(event)));
  }

  RubricaState _itemSeleccionadoProcess(ItemSeleccionadoChanged event) {
    List<Criterio> criterios = state.rubrica.criterios;
    criterios[event.numCriterio] = criterios
        .elementAt(event.numCriterio)
        .copyWith(itemSeleccionado: event.itemSeleccionado);

    return state.copyWith(
        rubrica: state.rubrica.copyWith(criterios: criterios));
  }

  RubricaState _comentarioChangedProcess(ComentarioCriterioChanged event) {
    List<Criterio> criterios = state.rubrica.criterios;
    criterios[event.numCriterio] = criterios
        .elementAt(event.numCriterio)
        .copyWith(comentario: event.comentario);

    return state.copyWith(
        rubrica: state.rubrica.copyWith(criterios: criterios));
  }

  RubricaState _procedimientoCheckedProcess(ProcedimientoChecked event) {
    List<String> procedimientos = [
      ...state.rubrica.procedimientosSeleccionados
    ];
    procedimientos.add(event.codigo);
    print(procedimientos);
    return state.copyWith(
        rubrica: state.rubrica
            .copyWith(procedimientosSeleccionados: procedimientos));
  }

  RubricaState _procedimientoUncheckedProcess(ProcedimientoUnchecked event) {
    List<String> procedimientos = [
      ...state.rubrica.procedimientosSeleccionados
    ];
    procedimientos.remove(event.codigo);

    return state.copyWith(
        rubrica: state.rubrica
            .copyWith(procedimientosSeleccionados: procedimientos));
  }

  RubricaState _patologiaCheckedProcess(PatologiaChecked event) {
    List<String> patologias = [...state.rubrica.patologiasSeleccionadas];
    patologias.add(event.codigo);
    print(patologias);
    return state.copyWith(
        rubrica: state.rubrica.copyWith(patologiasSeleccionadas: patologias));
  }

  RubricaState _patologiaUncheckedProcess(PatologiaUnchecked event) {
    List<String> patologias = [...state.rubrica.patologiasSeleccionadas];
    patologias.remove(event.codigo);

    return state.copyWith(
        rubrica: state.rubrica.copyWith(patologiasSeleccionadas: patologias));
  }

  RubricaState _comentarioGeneralChangedProcess(
      ComentarioGeneralChanged event) {
    return state.copyWith(
        rubrica: state.rubrica.copyWith(comentarioGeneral: event.comentario));
  }
}
