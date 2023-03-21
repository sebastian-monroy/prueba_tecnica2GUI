

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prueba_tecnica/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier{
  final String _baseUrl = 'flutter-varios-89287-default-rtdb.firebaseio.com';
  final List<Products> products = [];
  late Products selectedProduct;
  bool isLoading = true;
  bool isSaving = false;


  ProductsServices(){
    this.loadProducts();
  }

  Future <List<Products>> loadProducts() async {

    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    Products? selectedProduct;

    final Map<String, dynamic> productsMap = json.decode (resp.body);

    productsMap.forEach((key, value) { 
      final tempProduct = Products.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);  
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
  }


  Future saveOrCreateProduct(Products product) async {
    isSaving = true;
    notifyListeners();

    if(product.id == null ){
      //crear
      await this.createProduct(product);
    }else{
      //actualizar
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Products product) async {

    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    final index = this.products.indexWhere((element) => element.id == product.id);

    this.products[index] = product;

    return product.id!;
  }

    Future<String> createProduct(Products product) async {

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData =json.decode(resp.body) ;

    final index = this.products.indexWhere((element) => element.id == product.id);

    product.id = decodedData['name'];
    
    this.products.add(product);

    return product.id!;
    
  }
}