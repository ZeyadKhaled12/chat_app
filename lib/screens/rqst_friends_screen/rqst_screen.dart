import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/rqst_friends_screen/rqst_widget.dart';
import 'package:provider/provider.dart';


class RqstScreen extends StatefulWidget {
  @override
  _RqstScreenState createState() => _RqstScreenState();
}

class _RqstScreenState extends State<RqstScreen> {

  FunFun _funFun = new FunFun();

  List<dynamic> _names = [
    'Hesham sobhi',
    'Khaled waleed',
    'omar sayed',
    'Ebrahim',
    'Sayed sobhi',
    'ramdan kola',
    'hoba sosa',
    'lomnada seka',
    'monika  jod',
    'maged'
  ];

  List<dynamic> _color = [
    Colors.black,
    Colors.grey,
    Colors.brown,
    Colors.deepPurple,
    Colors.pinkAccent,
    Colors.teal,
    Colors.red,
    Colors.amber,
    Colors.pink,
    Colors.deepOrange
  ];


  Future _startFunc() async{

    
    String? docKey;
    await FirebaseFirestore.instance.collection('friendRqst')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('number').get().then((value) {
      docKey = value.docs[0].id;
    });
    
    await FirebaseFirestore.instance.collection('friendRqst')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .collection('number').doc(docKey).update({
      'number': 0
    });
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startFunc();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _startFunc();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('friendRqst').doc(
            '${FirebaseAuth.instance.currentUser?.uid}'
          ).collection('uid').snapshots(),
          builder: (ctx, snapShot){
            if(snapShot.connectionState == ConnectionState.waiting){
              return Center(child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)));
            }
            final docs = snapShot.data!.docs;
            if(docs.isEmpty){
              return Center(
                child: Text('You don\'t have invites.',
                  style: TextStyle(
                    color: Colors.yellowAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    fontFamily: 'french'
                  ),
                ),
              );
            }

              return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                return RqstWidget(
                  '${docs[index].id}',
                );
              }
            );
          },
        )
      ),
    );
  }
}
