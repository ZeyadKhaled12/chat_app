
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/chat_fun.dart';
import 'package:kaito/screens/chat_screen/friend_widget.dart';
import 'package:kaito/screens/chat_screen/friend_widget_btmsht.dart';
import 'invite_screen.dart';



class FriendsScreen extends StatefulWidget {


  @override
  _FriendsScreenState createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {







  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Opacity(opacity: 0.58, child: InviteScreen())
          );
        },


        //return InviteScreen();
        child: Icon(
          Icons.person_add,
          color: Theme.of(context).primaryColor,
          size: 35,
        ),
        backgroundColor: Colors.yellowAccent,
      ),

      body: Container(

        color: Theme.of(context).primaryColor,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('friends')
              .doc('${FirebaseAuth.instance.currentUser?.uid}')
              .collection('uid')
              .orderBy('createdAt',  descending: true)
              .snapshots(),
          builder: (ctx, snapShot){
            if(snapShot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
            }
            final docs = snapShot.data!.docs;
            if(docs.isEmpty){
              return Center(
                child: Text('You don\'t have any friends.',
                  style: TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'french'
                  ),
                ),
              );
            }
            return
              RefreshIndicator(
                onRefresh: () async{setState(() {});},
                color: Colors.yellowAccent,
                backgroundColor: Theme.of(context).primaryColor,
              child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (ctx, index){
                    print(docs.length);
                    print('\n\n\n\n\n\n${docs[index].get('msg').toString()}\n\n\n\n\n');
                    return InkWell(
                      onLongPress: () async{
                        await showModalBottomSheet(
                            //isScrollControlled: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) =>  FriendWidgetBtmsht(index, docs[index].id));
                      },
                      child: FriendWidget(
                          index,
                          docs[index].id,
                          docs[index].get('isNewMsg'),
                          docs[index].get('msg').toString(),
                          docs[index].get('createdAt')
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}


