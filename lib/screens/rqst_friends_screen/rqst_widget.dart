import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';




class RqstWidget extends StatefulWidget {
  final String _uid;
  final Key? key;

  RqstWidget(this._uid, {this.key});

  @override
  _RqstWidgetState createState() => _RqstWidgetState();
}

class _RqstWidgetState extends State<RqstWidget> {

  String? test = 'test';
  FunFun _funFun = new FunFun();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget._uid)
            .get()
            .then((value) {
          return [value.data()?['name'], value.data()?['color']];
        }),
        builder: (ctx, snapShot) {
          if(snapShot.connectionState == ConnectionState.waiting){
            return Container(
              //width: 300,
              height: 120,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  color: Colors.white.withOpacity(0.12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        SizedBox(
                          width: 66,
                          height: 66,
                          child: CircleAvatar(
                            backgroundColor: Colors.white
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        Text(
                          'User',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                                  ?.withOpacity(0.8),
                              fontSize: 18,
                              fontFamily: 'Sitka',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          print('\n\n\n\n\n\n${snapShot.data}\n\n\n\n\n\n');
          return Container(
            //width: 300,
            height: 120,
            child: Padding(
              padding: EdgeInsets.all(3),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                color: Colors.white.withOpacity(0.12),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(5)),
                      SizedBox(
                        width: 66,
                        height: 66,
                        child: CircleAvatar(
                          backgroundColor: _funFun.getColor(snapShot.data?[1]),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${snapShot.data?[0]}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.color
                                    ?.withOpacity(0.8),
                                fontSize: 18,
                                fontFamily: 'Sitka',
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: <Widget>[
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(40))),
                                  highlightColor: Colors.white,
                                  color: Colors.yellowAccent,
                                  onPressed: () async {
                                    DateTime time = new DateTime.utc(2009, 5, 8, 10, 27, 37, 0, 0);

                                    var user = FirebaseAuth.instance.currentUser;



                                    await FirebaseFirestore.instance
                                        .collection('friendRqst')
                                        .doc(user?.uid)
                                        .collection('uid')
                                        .doc(widget._uid)
                                        .delete();

                                    await FirebaseFirestore.instance
                                        .collection('friends')
                                        .doc(user?.uid)
                                        .collection('uid')
                                        .doc(widget._uid).set({
                                      'createdAt': time,
                                      'msg':'',
                                      'isNewMsg': false
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('friends')
                                        .doc(widget._uid)
                                        .collection('uid')
                                        .doc(user?.uid).set({
                                      'createdAt': time,
                                      'msg':'',
                                      'isNewMsg': false
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('chat')
                                        .doc(user?.uid)
                                        .collection('friends').doc(widget._uid).collection('msg').add({});

                                    await FirebaseFirestore.instance
                                        .collection('chat')
                                        .doc(widget._uid)
                                        .collection('friends').doc(user?.uid).collection('msg').add({});


                                  },
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(padding: EdgeInsets.all(4)),
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))),
                                  highlightColor: Colors.white,
                                  color: Colors.red,
                                  onPressed: () async{
                                    await FirebaseFirestore.instance
                                        .collection('friendRqst')
                                        .doc(FirebaseAuth
                                        .instance.currentUser?.uid)
                                        .collection('uid')
                                        .doc(widget._uid)
                                        .delete();
                                  },
                                  child: Text(
                                    'Deny',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        );
  }
}

/*
Container(
      //width: 300,
      height: 120,
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Card(
          shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          color: Colors.white24,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5)),
                SizedBox(
                  width: 66,
                  height: 66,
                  child: CircleAvatar(
                    backgroundColor: widget._color,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${'sd'}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.8),
                          fontSize: 18,
                          fontFamily: 'Sitka',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                            color: Colors.yellowAccent,
                            onPressed: (){}, child: Text(
                          'Accept',
                          style: TextStyle(
                              fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        )
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                        FlatButton(
                            color: Colors.red,
                            onPressed: (){}, child: Text(
                          'Deny',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        )
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),

        ),
      ),
    );
 */
