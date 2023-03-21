import 'package:flutter/material.dart';
import 'package:prueba_tecnica/models/movie.dart';
import 'package:prueba_tecnica/models/product.dart';

class MovieFormProvider extends ChangeNotifier {
  GlobalKey<FormState>formkey = new GlobalKey<FormState>();

  Products products;

  MovieFormProvider(this.products);

  bool isValidForm() {

    print(products.name);
    print(products.price);

    return formkey.currentState?.validate() ?? false;
  }
}