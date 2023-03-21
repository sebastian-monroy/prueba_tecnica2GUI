import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prueba_tecnica/providers/movies_form_provider.dart';
import 'package:prueba_tecnica/services/product_service.dart';
import 'package:prueba_tecnica/widgets/product_image.dart';
import 'package:provider/provider.dart';


class MovieScreen extends StatelessWidget {
  const MovieScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productsServices = Provider.of<ProductsServices>(context);

    return ChangeNotifierProvider(
      create: (_) => MovieFormProvider(productsServices.selectedProduct),
      child: _MoviesScreenProvider(productsServices: productsServices),
    );;
  }
}

class _MoviesScreenProvider extends StatelessWidget {
  const _MoviesScreenProvider({
    Key? key,
    required this.productsServices,
  }) : super(key: key);

  final ProductsServices productsServices;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<MovieFormProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
              children: [
                ProductImage(url: productsServices.selectedProduct.picture,),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: ()=> Navigator.of(context).pop( ), 
                    icon: Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white,)
                  )
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: (){
                      //camara o galeria
                    }, 
                    icon: Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,)
                  )
                )
              ],
            ),
            _ProductForm(),
            SizedBox( height: 100)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(Icons.save_outlined),
        onPressed: () async  {
          //guardar producto

         if(!productForm.isValidForm()) return;

         await productsServices.saveOrCreateProduct(productForm.products);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<MovieFormProvider>(context);
    final product = productForm.products;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(

          key: productForm.formkey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10,),

              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                  return 'El nombre es obligatorio';
                },
                decoration: InputDecoration(
                  hintText: 'Nombre del producto',
                  labelText: 'Nombre'
                ),
              ),

              SizedBox(height: 30,),

              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null ){
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'precio',
                  labelText: 'precio del producto'
                ),
              ),
              SizedBox(height: 30,),

              SizedBox(height: 30,)
            ],
          )
        ),
      ),
    );
  }
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        offset: Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}