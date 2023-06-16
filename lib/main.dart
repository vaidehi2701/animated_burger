import 'package:animated_burger/model/data.position.dart';
import 'package:flutter/material.dart';
import 'utils.dart';
import 'model/data_name.dart';
import 'model/data_value.dart';

void main() => runApp(const MyApp());

  //devDiariesWithVee on Instagram
 //devDiariesWithVee on Youtube
 //vaidehi2701 on Github/Linkedin

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      //home: ImageSizeAnimation(),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List foodItem = [];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/bg.png",
                ),
                fit: BoxFit.cover)),
        child: Column(children: [
          const SizedBox(
            height: 160,
          ),
          Expanded(
            child: Center(child: _animatedStack()),
          ),
          Expanded(
            child: checkBoxListview(),
          ),
        ]),
      ),
    );
  }

  Stack _animatedStack() {
    return Stack(
      children: [
        animatedPositioned(
            top: 230,
            animated: animatedOpacity(
                image: Image.asset(
                  ImagePath().bunBottom,
                  width: 250,
                  height: height2,
                ),
                opacity: open)),
        animatedPositioned(
            top: 215,
            animated: animatedOpacity(
                image: Image.asset(
                  ImagePath().cabbage,
                  width: 250,
                  height: height2,
                ),
                opacity: valuecabbage ? open : close)),
        animatedPositioned(
            top: valuecabbage ? etTop : 185,
            animated: animatedOpacity(
                image: Image.asset(
                  ImagePath().etPath,
                  width: 250,
                  height: height,
                ),
                opacity: open)),
        animatedPositioned(
            top: 170,
            animated: animatedOpacity(
                image: Image.asset(
                  ImagePath().cheesePath,
                  width: 250,
                  height: height,
                ),
                opacity: valuecheese ? open : close)),
        animatedPositioned(
            top: valuecheese ? tometoTop + 30 : tometoTop + 40,
            animated: animatedOpacity(
                image: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Image.asset(
                    ImagePath().tometoPath,
                    width: 150,
                    height: 80,
                  ),
                ),
                opacity: valuetometo ? open : close)),
        animatedPositioned(
            top: valuetometo && valuecheese
                ? 125
                : valuetometo
                    ? 140
                    : valuecheese
                        ? 155
                        : 160,
            animated: animatedOpacity(
                image: Image.asset(
                  ImagePath().bunTopPath,
                  width: 250,
                  height: height2,
                ),
                opacity: open)),
      ],
    );
  }

  Widget checkBoxListview() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListView(children: [
        chekbox(
            title: Text(
              FoodName().cabbageName,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'bobbyJones', fontSize: 25),
            ),
            value: valuecabbage,
            selected: selectedcabbage,
            onChanged: (_) {
              setState(() {
                valuecabbage = !valuecabbage;
                valuecabbage
                    ? foodItem.add(selectedcabbage)
                    : foodItem.remove(selectedcabbage);
              });
            }),
        chekbox(
            title: Text(FoodName().tometoName,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'bobbyJones',
                  fontSize: 25,
                )),
            value: valuetometo,
            selected: selectedtometo,
            onChanged: (_) {
              setState(() {
                valuetometo = !valuetometo;
                valuetometo
                    ? foodItem.add(selectedtometo)
                    : foodItem.remove(selectedtometo);
                valuetometo ? arttir() : azalt();
              });
            }),
        chekbox(
            title: Text(FoodName().cheeseName,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'bobbyJones',
                    fontSize: 25)),
            value: valuecheese,
            selected: selectedcheese,
            onChanged: (_) {
              setState(() {
                valuecheese = !valuecheese;
                valuecheese
                    ? foodItem.add(selectedcheese)
                    : foodItem.remove(selectedcheese);
                valuecheese ? arttir() : azalt();
              });
            })
      ]),
    );
  }
}

