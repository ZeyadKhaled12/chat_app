import 'package:flutter/material.dart';
import 'package:kaito/functions/friend_btmsht_fun.dart';



class FriendWidgetBtmsht extends StatefulWidget {
  final String _uid;
  final Key? key;
  final int index;

  FriendWidgetBtmsht(this.index, this._uid, {this.key});

  @override
  _FriendWidgetBtmshtState createState() => _FriendWidgetBtmshtState();
}

class _FriendWidgetBtmshtState extends State<FriendWidgetBtmsht> {

  FriendWidgetBtmshtFun _friendWidgetBtmshtFun = new FriendWidgetBtmshtFun();
  bool _isLoading = false;


  Widget listTitle(Icon icon, Text text, Function() func) {
    return ListTile(onTap: func, leading: icon, title: text);
  }

  Future dialog(String msg, double size, Function() fun){

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // <-- Radius
      ),
      backgroundColor: Colors.yellowAccent,
      title: Text(msg,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: size,
              fontWeight: FontWeight.bold
          )),
      content:
      Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Divider(
              thickness: 2.5,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 7,
            ),

            SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child:  FlatButton(
                        highlightColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: fun,
                        color: Theme.of(context).primaryColor,
                        child: Text('Yes', style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        )),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 5)),
                    SizedBox(
                      width: 100,
                      child:  FlatButton(
                        highlightColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async{
                          Navigator.of(context).pop();
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text('No', style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        )),
                      ),
                    )
                  ],
                )
            )

          ],
        ),
      )

    );

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Opacity(child: alert , opacity: 0.699999);
        });
  }

  Future _removeAllMyChat () async {
    setState(() {
      _isLoading = true;
    });

    Navigator.of(context).pop();
    await _friendWidgetBtmshtFun.removeAllMyChat(widget._uid);
  }

  Future _removeFriend () async {
    setState(() {
      _isLoading = true;
    });
    Navigator.of(context).pop();
    await _friendWidgetBtmshtFun.removeFriend(widget._uid);
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 20)),
          listTitle(
              Icon(Icons.delete, color: Colors.white70, size: 28),
              Text(
                'Remove all my chat',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ), () async {
                await dialog(
                  'Are you sure you want delete all your messages in this  chat?',
                  15,
                  _removeAllMyChat
                );
                if(_isLoading) {
                  Navigator.pop(context);
                }
          }),
          listTitle(
              Icon(Icons.block, color: Colors.white70, size: 28),
              Text(
                'Remove',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              () async{
                await dialog(
                    'Are you sure you want delete your friend?',
                    19,
                    _removeFriend
                );
                if(_isLoading) {
                  Navigator.pop(context);
                }
              }),
          Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}
