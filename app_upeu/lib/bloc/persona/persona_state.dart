part of 'persona_bloc.dart';

class PersonaState {}

class PersonaInitialState extends PersonaState {}

class PersonaLoadingState extends PersonaState {}

class PersonaLoadedState extends PersonaState {
  List<PersonaModelo> personaList;
  PersonaLoadedState(this.personaList);
}

class PersonaError extends PersonaState {
  Error e;
  PersonaError(this.e);
}
