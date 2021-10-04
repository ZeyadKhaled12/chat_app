import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/chat_fun.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/chat_screen/appbar_msg_screen.dart';
import 'package:provider/provider.dart';
import 'message_widget.dart';

class MsgScreen extends StatefulWidget {
  final String friendUid;
  final String name;
  final Color color;
  final bool isOnline;
  final Key? key;

  const MsgScreen(this.friendUid, this.name, this.color, this.isOnline, {this.key});

  @override
  _MsgScreenState createState() => _MsgScreenState();
}

class _MsgScreenState extends State<MsgScreen> {
  TextEditingController _newMsg = new TextEditingController();
  ChatFun _chatFun = new ChatFun();
  FunFun _funFun = new FunFun();

  Future _startFunc() async {
    await FirebaseFirestore.instance
        .collection('friends')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('uid')
        .doc(widget.friendUid)
        .update({'isNewMsg': false});
    Provider.of<UserDetails>(context, listen: false).changeIsDeleteFalse();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startFunc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
          automaticallyImplyLeading: false,
          title: AppBarMsgScreen(widget.name, widget.color, widget.isOnline)),

      body: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/chatImage.jpg'),
                    )),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 75),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chat')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('friends')
                      .doc(widget.friendUid)
                      .collection('msg')
                      .orderBy('createdAt', descending: true)
                      .snapshots(),
                  builder: (ctx, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.yellowAccent)));
                    }

                    final docs = snapShot.data!.docs;

                    return ListView.builder(
                      reverse: true,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: MessageWidget(
                            widget.friendUid,
                            docs[index].id,
                            widget.color,
                            docs[index]['text'],
                            docs[index]['userId'] ==
                                FirebaseAuth.instance.currentUser?.uid,
                          ),
                        );
                      },
                      itemCount: docs.length,
                    );
                  }),
            ),
            Container(
              width: 240,
              child: TextField(
                  onChanged: (value) {},
                  keyboardType: TextInputType.multiline,
                  //textInputAction: TextInputAction.next,
                  maxLines: null,
                  controller: _newMsg,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold),
                  cursorColor: Colors.yellowAccent,
                  decoration: InputDecoration(
                    fillColor: Colors.black12.withOpacity(0.69),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40)),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            bottomLeft: Radius.circular(40))),
                    hintText: 'Send New Message',
                    hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.yellowAccent.withOpacity(0.4)),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 64,
                  width: 50,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100)),
                      ),
                      color: Colors.black12.withOpacity(0.69),
                      onPressed: () async {
                        if (_funFun.isTyping(_newMsg.text)) {
                          String msg = _funFun.string;
                          _newMsg.clear();
                          await _chatFun.sendNewMsg(widget.friendUid, msg);
                        }
                      },
                      child: Center(
                          child: Icon(Icons.keyboard_arrow_right,
                              size: 40, color: Colors.yellowAccent))),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: FlatButton(
                      highlightColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100), // <-- Radius
                      ),
                      color: Colors.yellowAccent.withOpacity(0.6),
                      onPressed: () {},
                      child: Center(
                          child: Icon(Icons.mic,
                              size: 30,
                              color: Theme.of(context).primaryColor))),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
