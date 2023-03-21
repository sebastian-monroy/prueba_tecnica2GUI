import 'package:flutter/material.dart';
import 'package:prueba_tecnica/models/product.dart';
import 'package:prueba_tecnica/providers/movies_provider.dart';
import 'package:prueba_tecnica/screens/loading_screen.dart';
import 'package:prueba_tecnica/services/product_service.dart';
import 'package:prueba_tecnica/widgets/product_card.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) { 
     
    final productsService = Provider.of<ProductsServices>(context);



    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25)
          ),
        ),
        elevation: 0.00,
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct = productsService.products[index].copy();
            Navigator.pushNamed(context, 'Movie');
          }, 
          child: ProductCard(product: productsService.products[index],)
        ) //tarjetas de la pantalla 1
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
        onPressed: (){

          productsService.selectedProduct = new Products(
            available: false,
            name: '', 
            price: 0,
            
            
          );
          Navigator.pushNamed(context, 'Movie');
        },
      ),
    );
  }
}