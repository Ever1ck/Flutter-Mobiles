//import 'package:app_upeu/apis/api_beneficiario.dart';
import 'package:app_upeu/apis/persona_api.dart';
import 'package:app_upeu/comp/Button.dart';
import 'package:app_upeu/comp/TextInput.dart';
import 'package:app_upeu/drawer/navigation_home_screen.dart';
import 'package:app_upeu/login/sign_in.dart';
import 'package:app_upeu/modelo/UsuarioModelo.dart';
import 'package:app_upeu/util/TokenUtil.dart';
//import 'package:app_upeu/modelo/usuario_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginPage(),
    );*/
    return Provider<PersonaApi>(
      create: (_) => PersonaApi.create(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerUser = new TextEditingController();
  TextEditingController _controllerPass = new TextEditingController();
  var token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage("assets/imagen/logo_upeu.png"),
                  height: 200.0),
              //FlutterLogo(size: 150),
              SizedBox(height: 20),
              _buildForm(),
              SizedBox(height: 20),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildForm() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: <Widget>[
              TextInput(
                hint: 'Usuario:',
                controller: _controllerUser,
              ),
              SizedBox(height: 16),
              TextInput(
                hint: 'Clave:',
                controller: _controllerPass,
                obscure: true,
                //suffixIcon: Icons.password,
              ),
              SizedBox(
                height: 24,
              ),
              Button(
                label: 'Ingresar',
                onTap: () async {
                  print("Aqui no pasa :v");
                  WidgetsFlutterBinding.ensureInitialized();
                  Firebase.initializeApp();
                  if (_formKey.currentState.validate() &&
                      _controllerUser.text != "") {
                    print(
                        "Usuario: ${_controllerUser.text}  clave:${_controllerPass.text}");

                    final prefs = await SharedPreferences.getInstance();

                    final api = Provider.of<PersonaApi>(context, listen: false);
                    final user = UsuarioModelo();
                    user.email = _controllerUser.text;
                    user.password = _controllerPass.text;
                    bool ingreso = false;
                    api.login(user).then((value) {
                      token = value.token_type + " " + value.access_token;
                      prefs.setString("token", token);
                      TokenUtil.TOKEN = token;
                      ingreso = true;
                      if (ingreso == true) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return NavigationHomeScreen();
                            },
                          ),
                        );
                      }
                    }).catchError((onError) {
                      print(onError.toString());
                    });
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget _signInButton() {
    return OutlinedButton(
      //splashColor: Colors.grey,
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();

        /*signInWithGoogle().then((result) {
          if (result != null) {
            WidgetsFlutterBinding.ensureInitialized();
            Firebase.initializeApp();
            final api=Provider.of<BeneficiarioApi>(context,listen: false);
            final user=UsuarioModel();
            user.username="davidmpx";
            user.password="Davidmpx1";
            api.login(user).then((value){
              token="JWT "+value.access_token;
              prefs.setString("token", token);
              print(token);
            }).catchError((onError){
              print(onError.toString());
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return NavigationHomeScreen();
                },
              ),
            );
          }else{
            print("Errro!!");
          }
        });*/
      },
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      //highlightElevation: 0,
      //borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/imagen/man-icon.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Ingresar VinMenX',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
