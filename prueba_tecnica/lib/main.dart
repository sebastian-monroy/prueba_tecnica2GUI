import 'package:flutter/material.dart';
import 'package:prueba_tecnica/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/screens/movie_screen.dart';
import 'package:prueba_tecnica/services/product_service.dart';
import 'package:connection_status_bar/connection_status_bar.dart';  

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsServices()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context,_) => Stack(
        children: [
          MaterialApp(
            debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              routes: {
              'HomeScreen': (_) => HomeScreen(),
              'Movie': (_) => MovieScreen()
            },
              theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen(),
          ),
          Align(
          alignment: Alignment.topCenter,
          child: ConnectionStatusBar(
            color: Colors.red,
            lookUpAddress: "google.com",
            height: 40.0,
            title: Material(
              color: Colors.transparent,
              child: Text('Verifica la conexion',style: TextStyle(color: Colors.white,fontSize: 15.0),)),
          ),
        )
        ],
      ),
      
    );
  }
}

