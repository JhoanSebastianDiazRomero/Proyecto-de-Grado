part of 'rubrica_bloc.dart';

abstract class RubricaEvent {}

class EstudianteChanged extends RubricaEvent {
  final Estudiante estudiante;
  EstudianteChanged({required this.estudiante});
}

class StepChanged extends RubricaEvent {
  final int currentStep;
  StepChanged({required this.currentStep});
}

class DropdownChanged extends RubricaEvent {
  final String dropdownValue;
  DropdownChanged({required this.dropdownValue});
}

class ItemSeleccionadoChanged extends RubricaEvent {
  final int numCriterio;
  final int itemSeleccionado;
  ItemSeleccionadoChanged(
      {required this.numCriterio, required this.itemSeleccionado});
}

class ComentarioCriterioChanged extends RubricaEvent {
  final int numCriterio;
  final String comentario;
  ComentarioCriterioChanged(
      {required this.numCriterio, required this.comentario});
}

class SelectedListChanged extends RubricaEvent {
  final String selectedList;
  SelectedListChanged({required this.selectedList});
}

class ProcedimientoChecked extends RubricaEvent {
  final String codigo;
  ProcedimientoChecked({required this.codigo});
}

class ProcedimientoUnchecked extends RubricaEvent {
  final String codigo;
  ProcedimientoUnchecked({required this.codigo});
}

class PatologiaChecked extends RubricaEvent {
  final String codigo;
  PatologiaChecked({required this.codigo});
}

class PatologiaUnchecked extends RubricaEvent {
  final String codigo;
  PatologiaUnchecked({required this.codigo});
}

class ComentarioGeneralChanged extends RubricaEvent {
  final String comentario;
  ComentarioGeneralChanged({required this.comentario});
}

class LoadScreen extends RubricaEvent {
  final Rubrica rubrica;
  LoadScreen({required this.rubrica});
}

class ScreenLoaded extends RubricaEvent {
  final bool terminoCarga;
  ScreenLoaded({required this.terminoCarga});
}
