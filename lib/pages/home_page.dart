import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pokeapp/models/pokemon.dart';
import 'package:pokeapp/pages/detail_page.dart';
import 'package:pokeapp/styles.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var url = Uri.parse('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
  late Future<List> pokemons;

  @override
  void initState() {
    super.initState();
    pokemons = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke App'),
        centerTitle: true,
        backgroundColor: primaryColor,

      ),
      body: FutureBuilder(
        future: pokemons,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return GridView.count(
              crossAxisCount: 2,
              children: getPokemonCard(snapshot.data),
            );
          } else if(snapshot.hasError) {
            return const Center(child: Text('Error to load data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(Icons.refresh_outlined),
        backgroundColor: Colors.cyan,
      ),
    );
  }

  Future<List> fetchData() async{
    List pokemons = [];
    var response = await http.get(url);
    var decodedJson =  jsonDecode(response.body);
    for(var item in decodedJson['pokemon']){
      List<String> types = [];
      for(var type in item['type']){
        types.add(type);
      }
      List<String> weaknesses = [];
      for(var weakness in item['weaknesses']){
        weaknesses.add(weakness);
      }
      int candy_count = 0;
      if(item['candy_count']!= null)
        candy_count = item['candy_count'];

      pokemons.add(Pokemon(
          item['id'],
          item['num'],
          item['name'],
          item['img'],
          types,
          item['height'],
          item['weight'],
          item['candy'],
          candy_count,
          item['egg'],
          item['spawn_chance'].toString(),
          item['avg_spawns'].toString(),
          item['spawn_time'],
          weaknesses)
      );
    }
    return pokemons;
  }

  List<Widget> getPokemonCard(data){
    List<Widget> pokemons = [];
    for(var pokemon in data){
      pokemons.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(pokemon)));
          },
          child: Hero(
            tag: pokemon.img,
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(pokemon.img))
                    ),
                  ),
                  Text(pokemon.name, style: nameCard)
                ],
              ),
            ),
          ),
        ),
      )
      );
    }
    return pokemons;
  }
}