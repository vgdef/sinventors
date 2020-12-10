import 'package:sinventors/fragment.dart' as Fragments;
import 'package:flutter/material.dart';
import 'package:sinventors/main/home_page.dart' as Barang;

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class Beranda extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Beranda", Icons.home),
    new DrawerItem("Barang", Icons.computer),
    new DrawerItem("Distribusi", Icons.computer)
  ];

  @override
  State<StatefulWidget> createState() {
    return new BerandaState();
  }

}

class BerandaState extends State<Beranda> {
  int _selectedDrawerIndex = 0;

  _getDrawerFragment(int pos) {
    switch (pos) {
      case 0:
        return new Dashboards();
      case 1:
        return new Barang.MyApp();
      case 2:
        return new Fragments.Distribusi();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);

    Navigator.of(context).pop();
  }

  @override
Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];

    for (var i = 0; i <widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add (
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
  }

  // scaffold beranda 
  return new Scaffold(
    appBar: new AppBar(
      title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
    ),

    drawer: new Drawer(
      child: new Column (
        children: <Widget>[
          new UserAccountsDrawerHeader(
                accountName: null,
                accountEmail: null,
                currentAccountPicture: new CircleAvatar(backgroundImage:
                 new AssetImage(""),),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(""),
                fit: BoxFit.cover
              )
            ),
                ),
            new Column(children: drawerOptions)
        ],
      ),
    ),
    body: _getDrawerFragment(_selectedDrawerIndex),
  );
 }
}

// tampilkan dashboard 
class Dashboards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Text("Beranda");
  }
}