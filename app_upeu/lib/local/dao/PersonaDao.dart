import 'package:app_upeu/local/db/db_creation.dart';
import 'package:app_upeu/modelo/PersonaModelo.dart';

class PersonaLocate extends BaseRepository {
  Future<List<PersonaModelo>> getAllPersona() async {
    final db = await database;
    var result = await db.rawQuery('SELECT * FROM persona');
    List<PersonaModelo> listProduct = result.isNotEmpty
        ? result.map((c) => PersonaModelo.fromObject(c)).toList()
        : [];
    return listProduct;
  }

  Future<MsgModelo> insertPersona(PersonaModelo persona) async {
    final db = await database;
    var result = await db.rawInsert(
        'INSERT INTO persona(dni, nombre, apellido_paterno, apellido_materno, telefono, genero, correo) VALUES(?,?,?,?,?,?,?)',
        [
          persona.dni,
          persona.nombre,
          persona.apellido_paterno,
          persona.apellido_materno,
          persona.telefono,
          persona.genero,
          persona.correo
        ]);
    Map<String, dynamic> resultado = {'mensaje': "Se creo correctamente"};
    if (result == 1) {
      return Future.value(MsgModelo.fromJson(resultado));
    }
    resultado["mensaje"] = "No se pudo Registrar";
    return Future.value(MsgModelo.fromJson(resultado));
  }

  //Actualizar Datos
  Future<MsgModelo> updatePersona(PersonaModelo persona) async {
    final db = await database;
    int result = await db.update('persona', persona.toMap(),
        where: 'id = ${persona.id}');
    Map<String, dynamic> resultado = {'mensaje': "updated!!"};
    if (result == 1) {
      return Future.value(MsgModelo.fromJson(resultado));
    }
    resultado["mensaje"] = "No se pudo modificar los datos";
    return Future.value(MsgModelo.fromJson(resultado));
  }

  //Eliminar
  Future<MsgModelo> deletePersona(int id) async {
    final db = await database;
    var res = await db.delete('persona', where: 'id = $id');
    Map<String, dynamic> resultado = {'mensaje': "Deleted!!", 'id': id};
    if (res == 1) {
      return Future.value(MsgModelo.fromJson(resultado));
    }
    resultado["mensaje"] = "Error al eliminar";
    return Future.value(MsgModelo.fromJson(resultado));
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete('persona');
  }
}
