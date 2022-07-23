import 'package:flutter/material.dart';
import 'package:pokeapp/styles.dart';

import '../models/pokemon.dart';

class DetailPage extends StatelessWidget{

  Pokemon pokemon;
  DetailPage(this.pokemon);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(pokemon.name),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            height: size.height/1.5,
            width: size.width - 20,
            left: 10,
            top: size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 70,),
                  Text(pokemon.name, style: nameCard,),
                  Text('Height: ${pokemon.height}'),
                  Text('Weight: ${pokemon.weight}'),
                  const Text('Types', style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type.map((e) => FilterChip(label: Text(e), backgroundColor: Colors.amber, onSelected: (b){})).toList(),
                  ),
                  const Text('Weakness', style: TextStyle(fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses.map((e) => FilterChip(label: Text(e, style: TextStyle(color: Colors.white),), backgroundColor: Colors.red, onSelected: (b){})).toList(),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(pokemon.img),
                  fit: BoxFit.cover
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}