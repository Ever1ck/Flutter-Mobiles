import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PersonaModeloFire {
  String id,
      dni,
      nombre,
      apellido_paterno,
      apellido_materno,
      telefono,
      genero,
      correo;
  PersonaModeloFire(
      {this.id,
      this.dni,
      this.nombre,
      this.apellido_paterno,
      this.apellido_materno,
      this.telefono,
      this.genero,
      this.correo});
  factory PersonaModeloFire.fromJson(Map<String, dynamic> map) {
    return PersonaModeloFire(
      id: map['id'],
      dni: map['dni'],
      nombre: map['nombre'],
      apellido_paterno: map['apellido_paterno'],
      apellido_materno: map['apellido_materno'],
      telefono: map['telefono'],
      genero: map['genero'],
      correo: map['correo'],
    );
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["dni"] = dni;
    map["nombre"] = nombre;
    map["apellido_paterno"] = apellido_paterno;
    map["apellido_materno"] = apellido_materno;
    map["telefono"] = telefono;
    map["genero"] = genero;
    map["correo"] = correo;
    return map;
  }

  @override
  String toString() {
    return 'PersonaModeloFire{id: $id,dni: $dni, nombre: $nombre, apellido_paterno: $apellido_paterno,apellido_materno: $apellido_materno, telefono: $telefono, genero: $genero, correo:$correo}';
  }
}
