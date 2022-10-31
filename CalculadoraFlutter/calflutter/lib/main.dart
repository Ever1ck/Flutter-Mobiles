// @dart=2.9
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import './comp/CalcButton.dart';

void main() => runApp(CalcApp());

class CalcApp extends StatefulWidget {
  const CalcApp({Key key}) : super(key: key);
  @override
  CalcAppState createState() => CalcAppState();
}

const Color m3BaseColorD = Color(0xff99ff05);
const Color m3BaseColor = Color(0xff6750a4);
const List<Color> colorOptions = [
  m3BaseColor,
  m3BaseColorD,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink
];
const List<String> colorText = <String>[
  "M3 Baseline",
  "M3 BaselineD",
  "Blue",
  "Teal",
  "Green",
  "Yellow",
  "Orange",
  "Pink",
];

class CalcAppState extends State<CalcApp> {
  bool useMaterial3 = true;
  bool useLightMode = true;
  int colorSelected = 0;
  ThemeData themeData;
  String valorAnt = '';
  String operador = '';
  TextEditingController _controller = new TextEditingController();
  void numClick(String text) {
    setState(() => _controller.text += text);
    print(_controller);
  }

  void clear(String text) {
    setState(() {
      _controller.text = '';
    });
  }

  void opeClick(String text) {
    setState(() {
      valorAnt = _controller.text;
      operador = text;
      _controller.text = '';
    });
  }

  void resultRaiz(String text) {
    setState(() {
      _controller.text = "${pi}";
    });
  }

  void raizCuadrada(String text) {
    setState(() {
      _controller.text = pow(int.parse(_controller.text), 1 / 2).toString();
    });
  }

  void poteciaCuadrado(String text) {
    setState(() {
      _controller.text = pow(int.parse(_controller.text), 2).toString();
    });
  }

  void resultOperacion(String text) {
    setState(() {
      switch (operador) {
        case "/":
          _controller.text =
              (int.parse(valorAnt) / int.parse(_controller.text)).toString();
          break;
        case "*":
          _controller.text =
              (int.parse(valorAnt) * int.parse(_controller.text)).toString();
          break;
        case "+":
          _controller.text =
              (int.parse(valorAnt) + int.parse(_controller.text)).toString();
          break;
        case "-":
          _controller.text =
              (int.parse(valorAnt) - int.parse(_controller.text)).toString();
          break;
        case "%":
          _controller.text =
              (int.parse(valorAnt) % int.parse(_controller.text)).toString();
          break;
        case "x^x":
          _controller.text =
              pow(double.parse(valorAnt), int.parse(_controller.text))
                  .toString();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List> labelList = [
      ["AC", "C", "%", "/"],
      ["√", "π", "χ²", "x^x"],
      ["7", "8", "9", "*"],
      ["4", "5", "6", "-"],
      ["1", "2", "3", "+"],
      [".", "0", "00", "="]
    ];
    List<List> funx = [
      [clear, clear, opeClick, opeClick],
      [raizCuadrada, resultRaiz, poteciaCuadrado, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, opeClick],
      [numClick, numClick, numClick, resultOperacion]
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: themeData,
      /*theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),*/
      home: Scaffold(
        appBar: createAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Theme.of(context).colorScheme.surfaceVariant,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  textAlign: TextAlign.end,
                  controller: _controller,
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(
                  labelList.length,
                  (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...List.generate(
                            labelList[index].length,
                            (indexx) => CalcButton(
                              text: labelList[index][indexx],
                              callback: funx[index][indexx] as Function,
                            ),
                          ),
                        ],
                      ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
  }

  ThemeData updateThemes(int colorIndex, bool useMaterial3, bool useLightMode) {
    return ThemeData(
        colorSchemeSeed: colorOptions[colorSelected],
        useMaterial3: useMaterial3,
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }

  void handleBrightnessChange() {
    setState(() {
      useLightMode = !useLightMode;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  void handleMaterialVersionChange() {
    setState(() {
      useMaterial3 = !useMaterial3;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = value;
      themeData = updateThemes(colorSelected, useMaterial3, useLightMode);
    });
  }

  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: useMaterial3 ? const Text("Material 3") : const Text("Material 2"),
      actions: [
        IconButton(
          icon: useLightMode
              ? const Icon(Icons.wb_sunny_outlined)
              : const Icon(Icons.wb_sunny),
          onPressed: handleBrightnessChange,
          tooltip: "Toggle brightness",
        ),
        IconButton(
          icon: useMaterial3
              ? const Icon(Icons.filter_3)
              : const Icon(Icons.filter_2),
          onPressed: handleMaterialVersionChange,
          tooltip: "Switch to Material ${useMaterial3 ? 2 : 3}",
        ),
        PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          itemBuilder: (context) {
            return List.generate(colorOptions.length, (index) {
              return PopupMenuItem(
                  value: index,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          index == colorSelected
                              ? Icons.color_lens
                              : Icons.color_lens_outlined,
                          color: colorOptions[index],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(colorText[index]))
                    ],
                  ));
            });
          },
          onSelected: handleColorSelect,
        ),
      ],
    );
  }
}

/*import 'package:flutter/material.dart';

void main() {
  //runApp(const MyApp());
}*/