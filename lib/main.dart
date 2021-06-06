import 'package:bottom_navigation_bar/widgets/bottom_navigation/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onPressed: (index) => print('$index'),
        initialIndex: 2,
        iconClickColor: Colors.white,
        iconUnclickColor: Colors.red,
        clickColor: Colors.orange,
        backgroundColor: Colors.blue,
        labelColor: Colors.black,
        actions: [
          NavigationAction(
            icon: Icon(Icons.person),
            label: 'Person',
          ),
          NavigationAction(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          NavigationAction(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationAction(
            icon: Icon(Icons.details_outlined),
            label: 'Detail',
          ),
          NavigationAction(
            icon: Icon(Icons.maps_ugc),
            label: 'Map',
          ),
        ],
      ),
    );
  }
}
