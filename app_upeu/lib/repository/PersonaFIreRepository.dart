import 'package:app_upeu/modelo/PersonaModeloFire.dart';
import 'package:app_upeu/util/NetworConnection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonaFireRepository {
  CollectionReference db = FirebaseFirestore.instance.collection("persona");
  Future<List<PersonaModeloFire>> getPersona() async {
    if (await isConected()) {
      var data = await db.get();
      var persona = data.docs.map((e) {
        final model = PersonaModeloFire.fromJson(e.data());
        model.id = e.id;
        return model;
      }).toList();
      return persona;
    } else {
      print('No internet');
    }
  }

  Future<void> createPersona(PersonaModeloFire persona) async {
    if (await isConected()) {
      return await db
          .add(persona.toMap())
          .then((value) => print("El id es : ${value.id}"))
          .catchError((onError) => print("Error $onError"));
    } else {
      print('No internet');
    }
  }

  Future<void> deletePersona(String id) async {
    if (await isConected()) {
      return await db
          .doc(id)
          .delete()
          .then((value) => print("Persona Deleted "))
          .catchError((error) => print("Failed to delete Persona: $error"));
    } else {
      print('No hay conexion a internet FireBase!!');
    }
  }

  Future<void> updatePersona(String id, PersonaModeloFire persona) async {
    if (await isConected()) {
      print("Verrr: ${id}");
      return await db
          .doc(id)
          .update(persona.toMap())
          .then((value) => print("Persona Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } else {
      print('No hay conexion a internet FireBase!!');
    }
  }
}
