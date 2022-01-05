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

class SelectedRadioBtnsChanged extends RubricaEvent {
  final List<int> selectedRadioBtns;
  SelectedRadioBtnsChanged({required this.selectedRadioBtns});
}

class SelectedListChanged extends RubricaEvent {
  final String selectedList;
  SelectedListChanged({required this.selectedList});
}

class LoadScreen extends RubricaEvent {
  final Rubrica rubrica;
  LoadScreen({required this.rubrica});
}
