import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';





class AppBarHomeScreen extends StatefulWidget {

  @override
  _AppBarHomeScreenState createState() => _AppBarHomeScreenState();

}

class _AppBarHomeScreenState extends State<AppBarHomeScreen> {


  bool _isSearch = true;


  @override
  Widget build(BuildContext context) {

    return SliverAppBar(

      pinned: true,
      floating: true,
      snap: true,


      title:
      _isSearch == false?


      Text(''):

      Text('Kaito', style: TextStyle(
          fontFamily: 'comfortaa',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyText1?.color)),



      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      bottom: TabBar(
        isScrollable: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 6.0),
        unselectedLabelColor:
        Theme.of(context).textTheme.bodyText1?.color,
        labelColor: Colors.yellowAccent,
        indicatorColor: Colors.yellowAccent,
        indicatorWeight: 1,
        tabs: <Widget>[
          Tab(
            text: 'Friends',
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('friendRqst').doc(FirebaseAuth.instance.currentUser?.uid).collection('number').snapshots(),

                  builder: (ctx, snapShot){
                    if(snapShot.connectionState == ConnectionState.waiting){
                      return Text('');
                    }

                    final docs = snapShot.data!.docs;

                    return  docs[0].get('number') > 0? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellowAccent,
                        radius: 12,
                        child:  Text(
                          '${docs[0].get('number')}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ): Text('');

                  },
                ),
                Text('Requests', style: TextStyle(fontSize: 15)),
                // Padding(padding: EdgeInsets.only(right: 4)),


              ],
            ),
            //text: 'Friends request' + '   ${Provider.of<UserDetails>(context, listen: true).number}'
          ),

        ],
      ),
    );

  }

}
