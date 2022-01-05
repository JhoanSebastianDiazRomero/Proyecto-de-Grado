part of 'rubrica_bloc.dart';

class RubricaState {
  Rubrica rubrica;
  Estudiante estudiante;

  int currentStep;
  String dropdownValue;
  List<int> selectedRadioBtns;

  List<bool> selectedList;

  RubricaState(
      {required this.rubrica,
      required this.estudiante,
      required this.currentStep,
      required this.dropdownValue,
      required this.selectedRadioBtns,
      required this.selectedList});

  RubricaState copyWith({
    Rubrica? rubrica,
    Estudiante? estudiante,
    int? currentStep,
    String? dropdownValue,
    List<int>? selectedRadioBtns,
    List<bool>? selectedList,
  }) {
    return RubricaState(
        rubrica: rubrica ?? this.rubrica,
        estudiante: estudiante ?? this.estudiante,
        currentStep: currentStep ?? this.currentStep,
        dropdownValue: dropdownValue ?? this.dropdownValue,
        selectedRadioBtns: selectedRadioBtns ?? this.selectedRadioBtns,
        selectedList: selectedList ?? this.selectedList);
  }
}

class RubricaStateInitial extends RubricaState {
  RubricaStateInitial()
      : super(
            rubrica: Rubrica('', '', List<Criterio>.empty(), false, false, ''),
            estudiante: Estudiante('', ''),
            currentStep: 0,
            dropdownValue: 'Jhoan Sebastian Diaz Romero',
            selectedRadioBtns: List<int>.filled(6, -1),
            selectedList: List<bool>.empty());
}
