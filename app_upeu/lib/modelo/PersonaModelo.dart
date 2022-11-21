import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PersonaModelo {
  int id = 0;
  String dni,
      nombre,
      apellido_paterno,
      apellido_materno,
      telefono,
      genero,
      correo;
  PersonaModelo(
      {this.id,
      this.dni,
      this.nombre,
      this.apellido_paterno,
      this.apellido_materno,
      this.telefono,
      this.genero,
      this.correo});
  factory PersonaModelo.fromJson(Map<String, dynamic> map) {
    return PersonaModelo(
      id: map['id'] as int,
      dni: map['dni'],
      nombre: map['nombre'],
      apellido_paterno: map['apellido_paterno'],
      apellido_materno: map['apellido_materno'],
      telefono: map['telefono'],
      genero: map['genero'],
      correo: map['correo'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dni': dni,
      'nombre': nombre,
      'apellido_paterno': apellido_paterno,
      'apellido_materno': apellido_materno,
      'telefono': telefono,
      'genero': genero,
      'correo': correo,
    };
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = id;
    map["dni"] = dni;
    map["nombre"] = nombre;
    map["apellido_paterno"] = apellido_paterno;
    map["apellido_materno"] = apellido_materno;
    map["telefono"] = telefono;
    map["genero"] = genero;
    map["correo"] = correo;
    /*if (id != null) {
      map["id"] = id;
    }*/
    return map;
  }

  PersonaModelo.fromObject(dynamic o) {
    this.id = o["id"];
    this.dni = o["dni"];
    this.nombre = o["nombre"];
    this.apellido_paterno = o["apellido_paterno"];
    this.apellido_materno = o["apellido_materno"];
    this.telefono = o["telefono"];
    this.genero = o["genero"];
    this.correo = o["correo"];
    //this.edad = int.tryParse(o["edad"].toString());
  }

  @override
  String toString() {
    return 'PersonaModelo{id: $id,dni: $dni, nombre: $nombre, apellido_paterno: $apellido_paterno,apellido_materno: $apellido_materno, telefono: $telefono, genero: $genero, correo:$correo}';
  }
}

@JsonSerializable()
class ResponseModelo {
  bool success;
  List<PersonaModelo> data;
  String message;
  ResponseModelo({this.success, this.data, this.message});
  factory ResponseModelo.fromJson(Map<String, dynamic> map) {
    return ResponseModelo(
      success: map['success'] as bool,
      data: (map['data'] as List)
          ?.map((e) => e == null
              ? null
              : PersonaModelo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      message: map['message'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
    };
  }
}

@JsonSerializable()
class MsgModelo {
  String mensaje;

  MsgModelo({this.mensaje});
  factory MsgModelo.fromJson(Map<String, dynamic> map) {
    return MsgModelo(
      mensaje: map['mensaje'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'mensaje': mensaje,
    };
  }
}
