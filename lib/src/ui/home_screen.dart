import 'package:expiry/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:expiry/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:expiry/src/ui/pages/addProduct.dart';
import 'package:expiry/src/ui/pages/estadisticas.dart';
import 'package:expiry/src/ui/pages/notifications.dart';
import 'package:expiry/src/ui/pages/products.dart';
import 'package:expiry/src/ui/pages/settings.dart';
import 'package:expiry/src/ui/pages/stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:expiry/src/ui/pages/bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
  final String name;
  HomeScreen({Key key, @required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed:(){
              BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(child: Text('Bienvenido $name!'),)
        ],
      ),
    );
  }
}

class _HomeScreen extends State<HomeScreen> {
  int _page = 0;
 // GlobalKey _bottomNavigationKey = GlobalKey();

  final Products _products = new Products();
  final AddProduct _addProduct = new AddProduct();
  final Settings _settings = new Settings();
  final Statistics _statistics = new Statistics();
  final Notifications _notifications = new Notifications();



  Widget _initialPage = new Products();

  Widget _pageChoose(int page){

    switch(page){
      case 0:
        return _notifications;
        break;
      case 1:
        return _statistics ;
        break;
      case 2:
        return _addProduct;
        break;
      case 3:
        return  _products;
        break;

      case 4:
        return _settings ;
        break;
      default:

        return new Container(
          child: new Center(
            child: new Text(
              'No page found.',
                  style:new TextStyle(fontSize: 18),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _page,
          backgroundColor: Hexcolor("#FAFAFA") ,
          items: <Widget>[
            Icon(Icons.notifications_none , size: 20),
            Icon(Icons.timeline, size: 20),
            Icon(Icons.add_circle_outline, size: 20),
            Icon(Icons.home, size: 20),
            Icon(Icons.settings , size: 20),



          ],
          onTap: (int selectIndex ) {
            setState(() {
              _initialPage =  _pageChoose(selectIndex) ;
            });
          },
        ),
        body: Container(
          color: Hexcolor("#FAFAFA"),
          child: Center(
            child: _initialPage ,
          ),
        ));
  }
}




