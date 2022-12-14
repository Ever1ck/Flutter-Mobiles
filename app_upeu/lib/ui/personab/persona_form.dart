import 'package:app_upeu/apis/persona_api.dart';
import 'package:app_upeu/bloc/persona/persona_bloc.dart';
import 'package:app_upeu/theme/AppTheme.dart';
import 'package:app_upeu/modelo/PersonaModelo.dart';
import 'package:app_upeu/util/TokenUtil.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PersonaFormB extends StatefulWidget {
  @override
  _PersonaFormState createState() => _PersonaFormState();
}

List<Map<String, String>> lista = [
  {'value': 'M', 'display': 'Masculino'},
  {'value': 'F', 'display': 'Femenino'}
];

class _PersonaFormState extends State<PersonaFormB> {
  String _dni;
  String _nombre;
  String _apellido_p;
  String _apellido_m;
  String _telefono;
  String _genero;
  String _correo;

  int _edad;
  String _fecha_nac;
  var _data = [];

  @override
  void initState() {
    super.initState();
    print("ver: ${lista.map((item) => item['value']).toList()}");
    print("verv: ${lista.map((item) => item['display']).toList()}");
  }

  final _formKey = GlobalKey<FormState>();
  GroupController controller = GroupController();
  GroupController multipleCheckController = GroupController(
    isMultipleSelection: true,
  );

  Widget _buildDni() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'DNI:'),
      maxLength: 8,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'DNI Requerido!';
        }
        if (value.length != 8) {
          return 'DNI debe ser 8 digitos!';
        }
        return null;
      },
      onSaved: (String value) {
        _dni = value;
      },
    );
  }

  Widget _buildNombre() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nombre:'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nombre Requerido!';
        }
        return null;
      },
      onSaved: (String value) {
        _nombre = value;
      },
    );
  }

  Widget _buildApellidoPaterno() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apellido Pat:'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Apellido Paterno Requerido!';
        }
        return null;
      },
      onSaved: (String value) {
        _apellido_p = value;
      },
    );
  }

  Widget _buildApellidoMaterno() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Apellido Mat:'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Apellido Materno Requerido!';
        }
        return null;
      },
      onSaved: (String value) {
        _apellido_m = value;
      },
    );
  }

  Widget _buildTelefono() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Num. Telefono:'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Numero de Telefono Requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _telefono = value;
      },
    );
  }

  Widget _buildEdad() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Edad:'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Edad es campo Requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _edad = int.parse(value);
      },
    );
  }

  Widget _buildFechaNac() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'F. Nacimiento:'),
      keyboardType: TextInputType.datetime,
      validator: (String value) {
        if (value.isEmpty) {
          return 'F. Nacimiento es campo Requerido';
        }
        if (!RegExp(
                r"^\d{4}[\-\/\s]?((((0[13578])|(1[02]))[\-\/\s]?(([0-2][0-9])|(3[01])))|(((0[469])|(11))[\-\/\s]?(([0-2][0-9])|(30)))|(02[\-\/\s]?[0-2][0-9]))$")
            .hasMatch(value)) {
          return 'El formato de fecha no es correcto YYYY-mm-dd';
        }

        return null;
      },
      onSaved: (String value) {
        _fecha_nac = value;
      },
    );
  }

  Widget _buildGenero() {
    return DropDownFormField(
      titleText: 'Genero',
      hintText: 'Seleccione',
      value: _genero,
      onSaved: (value) {
        setState(() {
          _genero = value;
        });
      },
      onChanged: (value) {
        setState(() {
          _genero = value;
        });
      },
      dataSource: lista,
      textField: 'display',
      valueField: 'value',
    );
  }

  Widget _buildCorrero() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Correo:'),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Correo es campo Requerido';
        }
        return null;
      },
      onSaved: (String value) {
        _correo = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Form. Reg. Persona"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(24),
              color: AppTheme.nearlyWhite,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildDni(),
                    _buildNombre(),
                    _buildApellidoPaterno(),
                    _buildApellidoMaterno(),
                    _buildTelefono(),
                    _buildGenero(),
                    _buildCorrero(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: Text('Cancelar')),
                          ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Processing Data'),
                                  ),
                                );
                                _formKey.currentState.save();
                                PersonaModelo mp = new PersonaModelo();
                                mp.dni = _dni;
                                mp.nombre = _nombre;
                                mp.apellido_paterno = _apellido_p;
                                mp.apellido_materno = _apellido_m;
                                mp.telefono = _telefono;
                                mp.genero = _genero;
                                mp.correo = _correo;
                                BlocProvider.of<PersonaBloc>(context)
                                    .add(CreatePersonaEvent(persona: mp));
                                Navigator.pop(context, () {
                                  setState(() {});
                                });
                                /*var api = await Provider.of<PersonaApi>(context,
                                        listen: false)
                                    .createPersona(TokenUtil.TOKEN, mp);
                                print("ver: ${api.toJson()['success']}");
                                if (api.toJson()['success'] == true) {
                                  Navigator.pop(context, () {
                                    setState(() {});
                                  });
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationHomeScreen()));
                                }*/
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'No estan bien los datos de los campos!'),
                                  ),
                                );
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
