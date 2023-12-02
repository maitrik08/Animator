import 'dart:convert';

import 'package:animator/DetailScreen.dart';
import 'package:animator/Model.dart';
import 'package:animator/Planetmodel.dart';
import 'package:animator/Themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
List<Model> model = [];
class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin {
  late  AnimationController controller;

  @override
  void initState() {
    initializeData();
    super.initState();
  }
  Future<void> initializeData() async {
    await LoadJson();
    Provider.of<PlanetModel>(context, listen: false).loadJson();
    Provider.of<FavoritePlanetss>(context, listen: false).loadFavorites();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext context) {
    final favoritePlanetsManager = Provider.of<FavoritePlanetss>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Planets'),
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Favorite Planets'),
                      content: Consumer<FavoritePlanetss>(
                        builder:  (context, favoritePlanetsManager, child) {
                          return FavoritePlanet.isNotEmpty? Container(
                            height: FavoritePlanet.length * 50.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(int i = 0 ; i < FavoritePlanet.length;i++)...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${i+1}.  ${FavoritePlanet[i].name}'),
                                      IconButton(
                                          onPressed: () {
                                            favoritePlanetsManager.removeFromFavorites(FavoritePlanet[i]);
                                          },
                                          icon: Icon(Icons.remove_circle_outline)
                                      )
                                    ],
                                  )
                                ]
                              ],
                            ),
                          ):Text('No favorite planets added');
                        },
                      ),
                    );
                  },
                );
              }, 
              icon: Icon(Icons.favorite,color: Colors.redAccent,)
          ),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: (Provider.of<ThemeProvider>(context).isDark)
                ? const Icon(Icons.mode_night)
                : const Icon(Icons.light_mode_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            (Provider.of<ThemeProvider>(context).isDark)
                ?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRICR3xykWQIOBg3Na2swMlet9ratEvdTJPHg&usqp=CAU'
                :'https://cdn.pixabay.com/photo/2022/01/20/03/23/space-6951379_640.jpg',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          ListView.builder(
            itemCount: model.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(seconds: 2),
                child: InkWell(
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                        child: InkWell(
                          onTap: () {
                            modelindex = index;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen()));
                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: (Provider.of<ThemeProvider>(context).isDark)
                                  ?  Color(0x60626161)
                                  :Color(0x50FFFFFF),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: (Provider.of<ThemeProvider>(context).isDark)
                                      ?  Color(0x803a3939)
                                      :Color(0x50FFFFFF),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 2)
                                )
                              ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ImageHero(image: model[index].image, height: 95, width: 95),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:24,horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              model[index].name,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text('Position : ${model[index].position}')
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(Icons.arrow_forward_ios_outlined,size: 15,),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  Future LoadJson() async{
    String data = await rootBundle.loadString('assets/planets.json');
    List jsondata = jsonDecode(data);
    model = Model.parselist(jsondata);
    setState(() {});
  }
}
Widget ImageHero({required String image,required double height,required double width}){
  return Hero(
      tag: image,
      child: Image.network(image,height: height,width: width,),
  );
}