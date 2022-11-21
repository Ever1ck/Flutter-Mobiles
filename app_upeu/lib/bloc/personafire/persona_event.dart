part of 'persona_bloc.dart';

abstract class PersonaEvent {
  final PersonaModeloFire persona;
  const PersonaEvent({this.persona});
}

class ListarPersonaEvent extends PersonaEvent {
  ListarPersonaEvent();
}

class DeletePersonaEvent extends PersonaEvent {
  DeletePersonaEvent({@required PersonaModeloFire persona})
      : super(persona: persona);
}

class UpdatePersonaEvent extends PersonaEvent {
  UpdatePersonaEvent({@required PersonaModeloFire persona})
      : super(persona: persona);
}

class CreatePersonaEvent extends PersonaEvent {
  CreatePersonaEvent({@required PersonaModeloFire persona})
      : super(persona: persona);
}
