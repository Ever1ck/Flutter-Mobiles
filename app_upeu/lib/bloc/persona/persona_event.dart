part of 'persona_bloc.dart';

abstract class PersonaEvent {
  final PersonaModelo persona;
  const PersonaEvent({this.persona});
}

class ListarPersonaEvent extends PersonaEvent {
  ListarPersonaEvent();
}

class DeletePersonaEvent extends PersonaEvent {
  DeletePersonaEvent({@required PersonaModelo persona})
      : super(persona: persona);
}

class UpdatePersonaEvent extends PersonaEvent {
  UpdatePersonaEvent({@required PersonaModelo persona})
      : super(persona: persona);
}

class CreatePersonaEvent extends PersonaEvent {
  CreatePersonaEvent({@required PersonaModelo persona})
      : super(persona: persona);
}
