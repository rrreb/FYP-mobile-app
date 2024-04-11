import 'package:flutter/material.dart';
import 'camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          fontFamily: 'OpenSans',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            background: const Color(0xfff2f2f2),
            primary: const Color(0xaaaa7d29),
            // secondary: const Color(0xFFFFC107),
          )),
      home: MyHomePage(),
    );
  }
}

final Color primaryColor = Color(0xaaaa7d29);

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // final Color primaryColor = Color(0xaaaa7d29);

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: width * 0.475,
            flexibleSpace: Stack(children: <Widget>[
              Image(
                image: AssetImage('assets/images/banner-hermes.png'),
                fit: BoxFit.cover,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image(
                          image: AssetImage('assets/images/user.png'),
                          width: 55,
                          height: 55),
                      Text(
                        "Hi User!",
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ))
            ])),
        body: ListView(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    margin: EdgeInsets.only(top: 42, bottom: 86),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24, horizontal: 30),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Free AI\nAuthentication',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold)),
                        Text('Learn more',
                            style: TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.underline)),
                        SizedBox(height: 22),
                        OutlinedButton(
                          child: Text("Upload", style: TextStyle(fontSize: 20)),
                          style: OutlinedButton.styleFrom(
                            minimumSize: Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            side: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TakePhotoPage()),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: <Widget>[
                            Text(
                              '15',
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'APPRAISAL\nCOUNT',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Recent Appraisal List',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(height: 14),
                  AppraisalItem(
                      name: 'Hermes Birkin', rate: 79, date: '1 November 2023'),
                  AppraisalItem(
                      name: 'Hermes Birkin', rate: 79, date: '1 November 2023'),
                  AppraisalItem(
                      name: 'Hermes Birkin', rate: 79, date: '1 November 2023'),
                ],
              ),
            ),
          ],
        ));
  }
}

class AppraisalItem extends StatelessWidget {
  final String name;
  final int rate;
  final String date;

  const AppraisalItem({
    Key? key,
    required this.name,
    required this.rate,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 10),
        child: Row(children: <Widget>[
          Image(
            image: AssetImage('assets/images/temp-bag.png'),
            height: 88,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor),
                ),
                Text(
                  rate.toString() + '%',
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 24,
                      color: Colors.grey),
                ),
                Text(
                  date,
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 10,
                      color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
        ]));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
