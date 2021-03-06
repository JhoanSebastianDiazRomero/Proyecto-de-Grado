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
  final PItem item;
  ProcedimientoChecked({required this.item});
}

class ProcedimientoUnchecked extends RubricaEvent {
  final PItem item;
  ProcedimientoUnchecked({required this.item});
}

class PatologiaChecked extends RubricaEvent {
  final PItem item;
  PatologiaChecked({required this.item});
}

class PatologiaUnchecked extends RubricaEvent {
  final PItem item;
  PatologiaUnchecked({required this.item});
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
  final Curso curso;
  final String rubricaEscogida;
  LoadScreen({required this.curso, required this.rubricaEscogida});
}

class ScreenLoaded extends RubricaEvent {
  final bool terminoCarga;
  ScreenLoaded({required this.terminoCarga});
}
