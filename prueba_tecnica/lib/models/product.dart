// To parse this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'dart:convert';

class Products {
    Products({
        required this.available,
        required this.name,
        this.picture,
        required this.price,
        this.id
    });

    bool available;
    String name;
    String? picture;
    double price;
    String? id;

    factory Products.fromJson(String str) => Products.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Products.fromMap(Map<String, dynamic> json) => Products(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
    };
    Products copy() => Products(
      available: this.available,
      name: this.name,
      picture: this.picture,
      price: this.price,
      id: this.id,
    );
}