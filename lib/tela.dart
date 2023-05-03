import 'package:ecommecer/categoria.dart';
import 'package:flutter/material.dart';


class MinhaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200.0,
          backgroundColor: Color.fromARGB(255, 225, 95, 55),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Jennifer👋',
                      style: TextStyle(
                        fontSize: 27.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'What would you like to play?',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                radius: 35.0,
              ),
            ],
          ),
        ),
      body: Column(
  children: [
    Expanded(
      child: WidgetCategoria(),
    ),
    //Expanded(
      //child: GameListWidget(),
    //),
  ],
),



  ),
);
  }
}

