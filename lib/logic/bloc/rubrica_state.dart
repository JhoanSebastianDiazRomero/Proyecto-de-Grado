part of 'rubrica_bloc.dart';

class RubricaState {
  bool terminoCarga;

  Curso curso;
  Rubrica rubrica;
  List<Estudiante> estudiantes;
  EstadoRubrica estadoRubrica;

  int currentStep;
  Estudiante estudianteSeleccionado;

  List<PItem> procedimientos;
  List<PItem> procedimientosFiltrados;

  List<PItem> patologias;
  List<PItem> patologiasFiltradas;

  RubricaState(
      {required this.curso,
      required this.rubrica,
      required this.estudiantes,
      required this.estadoRubrica,
      required this.currentStep,
      required this.estudianteSeleccionado,
      required this.terminoCarga,
      required this.procedimientos,
      required this.procedimientosFiltrados,
      required this.patologias,
      required this.patologiasFiltradas});

  RubricaState copyWith(
      {bool? terminoCarga,
      Curso? curso,
      Rubrica? rubrica,
      List<Estudiante>? estudiantes,
      EstadoRubrica? estadoRubrica,
      int? currentStep,
      Estudiante? estudianteSeleccionado,
      List<PItem>? procedimientos,
      List<PItem>? procedimientosFiltrados,
      List<PItem>? patologias,
      List<PItem>? patologiasFiltradas}) {
    return RubricaState(
        curso: curso ?? this.curso,
        rubrica: rubrica ?? this.rubrica,
        estudiantes: estudiantes ?? this.estudiantes,
        estadoRubrica: estadoRubrica ?? this.estadoRubrica,
        currentStep: currentStep ?? this.currentStep,
        estudianteSeleccionado:
            estudianteSeleccionado ?? this.estudianteSeleccionado,
        terminoCarga: terminoCarga ?? this.terminoCarga,
        procedimientos: procedimientos ?? this.procedimientos,
        procedimientosFiltrados:
            procedimientosFiltrados ?? this.procedimientosFiltrados,
        patologias: patologias ?? this.patologias,
        patologiasFiltradas: patologiasFiltradas ?? this.patologiasFiltradas);
  }
}

class RubricaStateInitial extends RubricaState {
  RubricaStateInitial()
      : super(
            curso: Curso(nombre: '', codigo: '', estudiantes: [], rubricas: []),
            rubrica: Rubrica(
                nombre: '',
                descripcion: '',
                criterios: [],
                tieneProcedimientos: false,
                tienePatologias: false),
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
            procedimientos: [],
            procedimientosFiltrados: [],
            patologias: [],
            patologiasFiltradas: []);
}
