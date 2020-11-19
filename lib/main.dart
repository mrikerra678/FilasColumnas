import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int filas = 1;
  int columnas = 1;
  static const _itemCount = 10;

  PageController _filasControlador;
  PageController _columnasControlador;

  @override
  void initState() {
    super.initState();
    _filasControlador = PageController();
    _columnasControlador = PageController();
    _filasControlador.addListener(() => _establecerFC());
    _columnasControlador.addListener(() => _establecerFC());
  }

  @override
  void dispose() {
    _filasControlador.dispose();
    _columnasControlador.dispose();
    super.dispose();
  }

  _establecerFC() {
    setState(() {
      filas = _filasControlador.page.floor() + 1;
      columnas = _columnasControlador.page.floor() + 1;
      print('$filas, $columnas');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              child: PageView.builder(
                controller: _filasControlador,
                itemBuilder: (context, page) {
                  return Center(child: Text('${page + 1}'));
                },
                itemCount: _itemCount, // Can be null
              ),
            ),
            Divider(),
            SizedBox(
              height: 60,
              child: PageView.builder(
                controller: _columnasControlador,
                itemBuilder: (context, page) {
                  return Center(child: Text('${page + 1}'));
                },
                itemCount: _itemCount, // Can be null
              ),
            ),
            Divider(),
            for (var f = 0; f < filas; f++)
              Expanded(
                child: Row(children: [
                  for (var c = 0; c < columnas; c++)
                    Expanded(
                      child: Container(child: Text('$f$c')),
                    )
                ]),
              ),
          ],
        ),
      ),
    );
  }
}
