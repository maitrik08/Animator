import 'package:animator/HomeScreen.dart';
import 'package:animator/Model.dart';
import 'package:animator/Planetmodel.dart';
import 'package:animator/Themeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

int modelindex = 0;
List<Model> FavoritePlanet = [];
class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 18),
    );
    final curvedAnimation = CurvedAnimation(
      parent: rotationController,
      curve: Curves.linear,
    );
    rotationController.repeat();

    // Use curvedAnimation in your RotationTransition instead of rotationController
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlanetsManager = Provider.of<FavoritePlanetss>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(model[modelindex].name),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              if (FavoritePlanet.contains(model[modelindex])) {
                favoritePlanetsManager.removeFromFavorites(model[modelindex]);
              } else {
                favoritePlanetsManager.addToFavorites(model[modelindex]);
              }
            },
            child: Icon(
              FavoritePlanet.contains(model[modelindex])
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(width: 10,)
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
                    child: ImageHero(image: model[modelindex].image,width:340,height: 340),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: (Provider.of<ThemeProvider>(context).isDark)
                            ? Color(0x772d2d2d):
                        Color(0x77d9d9d9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name : ${model[modelindex].name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                            Divider(),
                            Text('Position: ${model[modelindex].position}'),
                            Divider(),
                            Text('Velocity: ${model[modelindex].velocity}'),
                            Divider(),
                            Text('Distance: ${model[modelindex].distance}'),
                          ],
                        ),
                      )
                  ),
                  SizedBox(height: 15),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: (Provider.of<ThemeProvider>(context).isDark)
                            ? Color(0x772d2d2d):
                        Color(0x77d9d9d9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(model[modelindex].description),
                          ],
                        ),
                      )
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }
}