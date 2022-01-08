import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tesis/logic/models/criterio.dart';
import 'package:tesis/logic/models/models.dart';

part 'rubrica_event.dart';
part 'rubrica_state.dart';

class RubricaBloc extends Bloc<RubricaEvent, RubricaState> {
  RubricaBloc() : super(RubricaStateInitial());

  Stream<RubricaState> mapEventToState(RubricaEvent event) async* {
    if (event is StepChanged) {
      yield state.copyWith(currentStep: event.currentStep);
    } else if (event is DropdownChanged) {
      yield state.copyWith(dropdownValue: event.dropdownValue);
    }
  }
}
