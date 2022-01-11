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

class EstudianteSeleccionadoChanged extends RubricaEvent {
  final Estudiante estudianteSeleccionado;
  EstudianteSeleccionadoChanged({required this.estudianteSeleccionado});
}

class ItemSeleccionadoChanged extends RubricaEvent {
  final String idCriterio;
  final int itemSeleccionado;
  ItemSeleccionadoChanged(
      {required this.idCriterio, required this.itemSeleccionado});
}

class ComentarioCriterioChanged extends RubricaEvent {
  final String idCriterio;
  final String comentario;
  ComentarioCriterioChanged(
      {required this.idCriterio, required this.comentario});
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

class FiltrarPatologias extends RubricaEvent {
  final List<PItem> patologiasFiltradas;
  FiltrarPatologias({required this.patologiasFiltradas});
}

class FiltrarProcedimientos extends RubricaEvent {
  final List<PItem> procedimientosFiltrados;
  FiltrarProcedimientos({required this.procedimientosFiltrados});
}

class ComentarioGeneralChanged extends RubricaEvent {
  final String comentario;
  ComentarioGeneralChanged({required this.comentario});
}

class LoadScreen extends RubricaEvent {
  final List<Estudiante> estudiantes;
  final Rubrica rubrica;
  final List<PItem> procedimientos;
  final List<PItem> patologias;
  LoadScreen(
      {required this.estudiantes,
      required this.rubrica,
      required this.procedimientos,
      required this.patologias});
}

class ScreenLoaded extends RubricaEvent {
  final bool terminoCarga;
  ScreenLoaded({required this.terminoCarga});
}
