import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/models/movie.dart';
import 'package:prueba_tecnica/models/product.dart';
import 'package:prueba_tecnica/providers/movies_provider.dart';


//estructura de las tarjetas
class ProductCard extends StatelessWidget {
  const ProductCard({ Key? key, required this.product, }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {

    //obtener la instancia de movies provider
    

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: CardsBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _Backgroundimage(product.picture),

            _ProductDetails(
              title: product.name,
              subTitle: product.id!,
            ),

            if( !product.available)
            Positioned(
              top: 0,
              right: 0,
              child: _IdTag(product.price)
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration CardsBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,5),
        blurRadius: 10
      )
    ]
  );
}

//id de la pelicula
class _IdTag extends StatelessWidget {
  const _IdTag(
     this.price,
  );

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(

      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$price',style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))
      ),
    );
  }
}

//descripcion de los productos
class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    Key? key, required this.title, required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: TextStyle(fontSize: 15, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

//imagen de la pantalla inicial
class _Backgroundimage extends StatelessWidget {
  const _Backgroundimage(
    this.url,
  );

  final String? url;

  @override
  Widget build(BuildContext context) {

    //obtener la instancia de movies provider
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
        ? Image(image: AssetImage('assets/no-image2.png'),
          fit: BoxFit.cover,
        )
        :FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}