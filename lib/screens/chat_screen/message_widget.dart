import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/chat_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:provider/provider.dart';



class MessageWidget extends StatefulWidget {




  final String _uid;
  final Color _color;
  final String _message;
  final bool _isMe;
  final String friendUid;
  final Key? key;


  MessageWidget(this.friendUid, this._uid, this._color, this._message, this._isMe, {this.key});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {


  ChatFun _chatFun = new ChatFun();



  @override
  Widget build(BuildContext context) {
    return widget._isMe?
    FlatButton(
      onPressed: (){
        if(Provider.of<UserDetails>(context, listen: false).isDelete) {
          _chatFun.deleteMsg(friendUid: widget.friendUid, msgUid: widget._uid);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Container(

              decoration: BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(0.58),//Theme.of(context).accentColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  )

              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(widget._message, style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                fontWeight: FontWeight.bold
              )),
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          //Padding(padding: EdgeInsets.all(10)),
        ],
      ),
    ):
    FlatButton(
      highlightColor: Colors.white,
      onPressed: (){},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 35,
            height: 35,
            child: CircleAvatar(
              backgroundColor: this.widget._color,
            ),
          ),
          Padding(padding: EdgeInsets.all(5)),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )

              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Text(widget._message, style: TextStyle(
               fontSize: 20,
                color: Theme.of(context).textTheme.bodyText1?.color,
                  fontWeight: FontWeight.bold
              )),
            ),
          )
        ],
      ),
    );
  }
}
