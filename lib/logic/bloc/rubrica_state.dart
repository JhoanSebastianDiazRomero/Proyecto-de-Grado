part of 'rubrica_bloc.dart';

class RubricaState {
  Rubrica rubrica;
  Estudiante estudiante;

  int currentStep;
  String dropdownValue;

  bool terminoCarga;

  RubricaState(
      {required this.rubrica,
      required this.estudiante,
      required this.currentStep,
      required this.dropdownValue,
      required this.terminoCarga});

  RubricaState copyWith(
      {Rubrica? rubrica,
      Estudiante? estudiante,
      int? currentStep,
      String? dropdownValue,
      int? criterioSeleccionado,
      List<String>? comentariosCriterios,
      List<bool>? selectedList,
      bool? terminoCarga}) {
    return RubricaState(
        rubrica: rubrica ?? this.rubrica,
        estudiante: estudiante ?? this.estudiante,
        currentStep: currentStep ?? this.currentStep,
        dropdownValue: dropdownValue ?? this.dropdownValue,
        terminoCarga: terminoCarga ?? this.terminoCarga);
  }
}

class RubricaStateInitial extends RubricaState {
  RubricaStateInitial()
      : super(
            rubrica: Rubrica(
                nombre: '',
                descripcion: '',
                criterios: List<Criterio>.empty(),
                tieneProcedimientos: false,
                procedimientosSeleccionados: List<String>.empty(),
                tienePatologias: false,
                patologiasSeleccionadas: List<String>.empty(),
                comentarioGeneral: ''),
            estudiante: Estudiante('', ''),
            currentStep: 0,
            dropdownValue: 'Jhoan Sebastian Diaz Romero',
            terminoCarga: false);
}
