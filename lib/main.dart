import 'package:flutter/material.dart';
import 'package:kalkulator_sederhana/components/Tombol.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Beranda(),
    );
  }
}

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  var inputan = '';
  var hasil = '';

  final List<String> fungsi = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Kalkulator"),
      ),
      backgroundColor: Colors.white38,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(
                        inputan,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerRight,
                      child: Text(
                        hasil,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: fungsi.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // tombol clear
                    if (index == 0) {
                      return Tombol(
                        tombolDitekan: () {
                          setState(() {
                            inputan = '';
                            hasil = '0';
                          });
                        },
                        tulisanTombol: fungsi[index],
                        warna: Colors.blue[50],
                        warnaTeks: Colors.black,
                      );
                    }

                    // tombol +/-
                    else if (index == 1) {
                      return Tombol(
                        tulisanTombol: fungsi[index],
                        warna: Colors.blue[50],
                        warnaTeks: Colors.black,
                      );
                    }
                    // tombol %
                    else if (index == 2) {
                      return Tombol(
                        tombolDitekan: () {
                          setState(() {
                            inputan += fungsi[index];
                          });
                        },
                        tulisanTombol: fungsi[index],
                        warna: Colors.blue[50],
                        warnaTeks: Colors.black,
                      );
                    }
                    // tombol hapus
                    else if (index == 3) {
                      return Tombol(
                        tombolDitekan: () {
                          setState(() {
                            inputan = inputan.substring(0, inputan.length - 1);
                          });
                        },
                        tulisanTombol: fungsi[index],
                        warna: Colors.blue[50],
                        warnaTeks: Colors.black,
                      );
                    }
                    // tombol sama dengan
                    else if (index == 18) {
                      return Tombol(
                        tombolDitekan: () {
                          setState(() {
                            prosesHitung();
                          });
                        },
                        tulisanTombol: fungsi[index],
                        warna: Colors.orange[700],
                        warnaTeks: Colors.white,
                      );
                    }
                    // lainnya
                    else {
                      return Tombol(
                        tombolDitekan: () {
                          setState(() {
                            inputan += fungsi[index];
                          });
                        },
                        tulisanTombol: fungsi[index],
                        warna: cekOperator(fungsi[index])
                            ? Colors.blueAccent
                            : Colors.white,
                        warnaTeks: cekOperator(fungsi[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool cekOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void prosesHitung() {
    String finalinputan = inputan;
    finalinputan = inputan.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalinputan);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    hasil = eval.toString();
  }
}
