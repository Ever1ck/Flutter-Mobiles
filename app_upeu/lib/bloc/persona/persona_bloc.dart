import 'dart:async';
import 'package:app_upeu/modelo/PersonaModelo.dart';
import 'package:app_upeu/repository/PersonaRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'persona_event.dart';
part 'persona_state.dart';

class PersonaBloc extends Bloc<PersonaEvent, PersonaState> {
/*final ProductosRepository _productosRepository;
ProductosBloc({ProductosRepository productosRepository}) :
_productosRepository=productosRepository,
super(ProductosInitialState());*/
  final PersonaRepository _personaRepository;
  PersonaBloc({PersonaRepository personaRepository})
      : _personaRepository = personaRepository,
        super(PersonaInitialState());
  @override
  Stream<PersonaState> mapEventToState(PersonaEvent event) async* {
    if (event is ListarPersonaEvent) {
      yield PersonaLoadingState();
      try {
        List<PersonaModelo> personaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(personaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    } else if (event is DeletePersonaEvent) {
      try {
        await _personaRepository.deletePersona(event.persona.id);
        yield PersonaLoadingState();
        List<PersonaModelo> personaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(personaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    } else if (event is CreatePersonaEvent) {
      try {
        await _personaRepository.createPersona(event.persona);
        yield PersonaLoadingState();
        List<PersonaModelo> personaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(personaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    } else if (event is UpdatePersonaEvent) {
      try {
        await _personaRepository.updatePersona(event.persona.id, event.persona);
        yield PersonaLoadingState();
        List<PersonaModelo> personaList = await _personaRepository.getPersona();
        yield PersonaLoadedState(personaList);
      } catch (e) {
        print("Error ${e.toString()}");
        yield PersonaError(e);
      }
    }
  }
}
