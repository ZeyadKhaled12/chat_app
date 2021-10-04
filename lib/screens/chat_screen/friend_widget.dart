import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/screens/chat_screen/msg_screen.dart';

class FriendWidget extends StatefulWidget {
  final String _uid;
  final Key? key;
  final _isNewMessage;
  final String _lastMessage;
  final Timestamp _date;
  final int index;

  FriendWidget(this.index, this._uid, this._isNewMessage, this._lastMessage, this._date,
      {this.key});

  @override
  _FriendWidgetState createState() => _FriendWidgetState();
}

class _FriendWidgetState extends State<FriendWidget> {
  FunFun _funFun = new FunFun();



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget._uid)
            .get()
            .then((value) {
          return [value.data()?['name'], value.data()?['color'], value.data()?['online']];
        }),
        builder: (ctx, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 100,
              child: Padding(
                padding: EdgeInsets.all(3),
                child: FlatButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MsgScreen(widget._uid, snapShot.data?[0],
                                _funFun.getColor(snapShot.data?[1]), snapShot.data?[2])));
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 66,
                          height: 66,
                          child: CircleAvatar(backgroundColor: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.all(13)),
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
          return Container(
            height: 100,
            child: Padding(
              padding: EdgeInsets.all(3),
              child:
              FlatButton(
                highlightColor: Colors.yellowAccent.withOpacity(0.2),

                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MsgScreen(widget._uid, snapShot.data?[0],
                              _funFun.getColor(snapShot.data?[1]), snapShot.data?[2])));
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 66,
                        height: 66,
                        child:
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [

                            CircleAvatar(
                              radius: 30,
                              backgroundColor: _funFun.getColor(snapShot.data?[1]),
                            ),
                            CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 12,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: snapShot.data?[2]? Colors.yellowAccent:Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(6)),
                      Flexible(
                        child: Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  widget._lastMessage.length > 15
                                      ? widget._lastMessage.substring(0, 10) +
                                      '........'
                                      : widget._lastMessage,
                                  style: TextStyle(
                                      color: widget._isNewMessage
                                          ? Colors.yellowAccent
                                          : Colors.grey,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold),
                                ),


                                Text(
                                  '${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget._date.millisecondsSinceEpoch))}',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
