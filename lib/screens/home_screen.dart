
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/appbar_home_screen.dart';
import 'package:kaito/screens/chat_screen/firends_screen.dart';
import 'package:kaito/screens/rqst_friends_screen/rqst_screen.dart';
import 'package:provider/provider.dart';


import 'drawer_screen/drawer_screen.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  Future _future () async{
    FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser?.uid).update({
      'online': true
    });
    await Provider.of<UserDetails>(context, listen: false).getUsers();
  }



  Future _startFun() async{
    await FirebaseFirestore.instance.collection('users').
    doc(FirebaseAuth.instance.currentUser?.uid).update({
      'online': true
    });
  }

  @override
  void initState() {

    _startFun();
    super.initState();


    _future();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        //initialIndex: selectedPage,
        length: 2,
        child: Scaffold(
          drawer: Opacity(
            opacity: 0.8,
            child: Drawer(
              child: DrawerScreen()
            ),
          ),




          body: NestedScrollView(
            floatHeaderSlivers: true,

            headerSliverBuilder: (context, inner) => [

              SliverOverlapAbsorber(

                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

                sliver: SliverSafeArea(
                  top: false,
                  sliver: AppBarHomeScreen()
                ),
              ),
            ],
            body: TabBarView(
              children: <Widget>[
                FriendsScreen(),
                RqstScreen(),
              ],
            ),
          )
        )
    );
  }
}
