part of 'rubrica_bloc.dart';

class RubricaState {
  bool terminoCarga;

  List<Estudiante> estudiantes;
  Rubrica rubrica;
  EstadoRubrica estadoRubrica;

  int currentStep;
  Estudiante estudianteSeleccionado;

  List<PItem> procedimientosFiltrados;
  List<PItem> patologiasFiltradas;

  RubricaState(
      {required this.estudiantes,
      required this.rubrica,
      required this.estadoRubrica,
      required this.currentStep,
      required this.estudianteSeleccionado,
      required this.terminoCarga,
      required this.procedimientosFiltrados,
      required this.patologiasFiltradas});

  RubricaState copyWith(
      {Rubrica? rubrica,
      List<Estudiante>? estudiantes,
      EstadoRubrica? estadoRubrica,
      int? currentStep,
      Estudiante? estudianteSeleccionado,
      String? dropdownValue,
      int? criterioSeleccionado,
      List<String>? comentariosCriterios,
      bool? terminoCarga,
      List<PItem>? procedimientosFiltrados,
      List<PItem>? patologiasFiltradas}) {
    return RubricaState(
        estudiantes: estudiantes ?? this.estudiantes,
        rubrica: rubrica ?? this.rubrica,
        estadoRubrica: estadoRubrica ?? this.estadoRubrica,
        currentStep: currentStep ?? this.currentStep,
        estudianteSeleccionado:
            estudianteSeleccionado ?? this.estudianteSeleccionado,
        terminoCarga: terminoCarga ?? this.terminoCarga,
        procedimientosFiltrados:
            procedimientosFiltrados ?? this.procedimientosFiltrados,
        patologiasFiltradas: patologiasFiltradas ?? this.patologiasFiltradas);
  }
}

class RubricaStateInitial extends RubricaState {
  RubricaStateInitial()
      : super(
            rubrica: Rubrica(
              id: '',
              nombre: '',
              descripcion: '',
              criterios: [],
              tieneProcedimientos: false,
              tienePatologias: false,
            ),
            estudiantes: [],
            estadoRubrica: EstadoRubrica(
                codigoEstudiante: '',
                idRubrica: '',
                estadosCriterios: {},
                patologiasSeleccionadas: [],
                procedimientosSeleccionados: [],
                comentarioGeneral: ''),
            currentStep: 0,
            estudianteSeleccionado: Estudiante(nombre: '', codigo: ''),
            terminoCarga: false,
            procedimientosFiltrados: [],
            patologiasFiltradas: []);
}
