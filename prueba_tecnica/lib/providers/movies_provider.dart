// este sera el proveedor de informacion de donde traemos los datos del api

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:prueba_tecnica/models/movie.dart';
import 'package:prueba_tecnica/models/now_playing_response.dart';


class MoviesProvider extends ChangeNotifier{

  String _apiKey  = 'b65f488d14ac62208f48402c06dbe173'; //llave que obtuvimos del api para suministrar la informacion
  String _baseUrl = 'api.themoviedb.org'; //esta es la base del url de donde construimos la api
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
  }

  //metodo para llamar al http peticiones https
  getOnDisplayMovies()async{
  var url = Uri.https(_baseUrl, '3/movie/now_playing', {
    'api_key': _apiKey,
    'language': _language,
    'page': '1'
  });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    
    print(response.body);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    print(nowPlayingResponse.results[1].title);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

}