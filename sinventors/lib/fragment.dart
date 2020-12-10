import 'package:flutter/material.dart';


  Widget createGridView(BuildContext context, List<String> cosmicBodies) {
    cosmicBodies.shuffle();

    // build my grid view 
    return new GridView.builder(
      itemCount: cosmicBodies.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
              child: new Text(cosmicBodies[index]),
            ),
          ),
        );
      }
      );
  }

  class Distribusi extends StatelessWidget {
    @override 
    Widget build(BuildContext context) {
      
      var distribusi = ["Pemindahan 1 komputer ke Farmasi", "Pemindahan 1 printer ke SDM & UMUM", "Pemindahan 1 komputer ke Gizi"];
    
      return createGridView(context, distribusi);
    }
  }
   

  