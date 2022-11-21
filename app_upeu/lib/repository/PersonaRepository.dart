import 'dart:async';
import 'package:app_upeu/apis/persona_api.dart';
import 'package:app_upeu/local/dao/PersonaDao.dart';
import 'package:app_upeu/modelo/PersonaModelo.dart';
import 'package:app_upeu/util/NetworConnection.dart';
import 'package:app_upeu/util/TokenUtil.dart';
import 'package:dio/dio.dart';

class PersonaRepository {
  PersonaApi personaApi;
  PersonaLocate personaLocal;
  bool result;

  PersonaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    personaApi = PersonaApi(_dio);
    personaLocal = PersonaLocate();
  }
  Future<List<PersonaModelo>> getPersona() async {
    if (await isConected()) {
      return await personaApi
          .getPersona(TokenUtil.TOKEN)
          .then((value) => value.data);
    } else {
      return await personaLocal.getAllPersona();
    }
  }

  Future<ResponseModelo> deletePersona(int id) async {
    return await personaApi.deletePersona(TokenUtil.TOKEN, id);
  }

  Future<ResponseModelo> updatePersona(int id, PersonaModelo persona) async {
    return await personaApi.updatePersona(TokenUtil.TOKEN, id, persona);
  }

  Future<ResponseModelo> createPersona(PersonaModelo persona) async {
    if (await isConected()) {
      return await personaApi.createPersona(TokenUtil.TOKEN, persona);
    } else {
      personaLocal.insertPersona(persona);
      return ResponseModelo();
    }
  }
}
