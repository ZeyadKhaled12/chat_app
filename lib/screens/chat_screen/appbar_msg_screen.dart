import 'package:flutter/material.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:provider/provider.dart';

class AppBarMsgScreen extends StatefulWidget {

  final String name;
  final Color color;
  final bool isOnline;
  final Key? key;

  AppBarMsgScreen(this.name, this.color, this.isOnline, {this.key});

  @override
  _AppBarMsgScreenState createState() => _AppBarMsgScreenState();
}

class _AppBarMsgScreenState extends State<AppBarMsgScreen> {

  bool _colorOfDelete = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          SizedBox(
            width: 60,
            child: FlatButton(
                highlightColor: Colors.yellowAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () {
                  setState(() {
                    _colorOfDelete = false;
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIsDeleteFalse();
                    print(Provider.of<UserDetails>(context, listen: false)
                        .isDelete);
                  });
                },
                onLongPress: () {
                  setState(() {
                    _colorOfDelete = !_colorOfDelete;
                    Provider.of<UserDetails>(context, listen: false)
                        .changeIsDelete();
                    print(Provider.of<UserDetails>(context, listen: false)
                        .isDelete);
                  });
                },
                color: _colorOfDelete
                    ? Colors.yellowAccent
                    : Colors.yellowAccent.withOpacity(0.5),
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                )),
          ),
        ]),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
              Text('${widget.name}',
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.all(6)),
             Stack(
               alignment: Alignment.bottomRight,
               children: [
                 CircleAvatar(
                   backgroundColor: widget.color,
                 ),
                 CircleAvatar(
                   radius: 8,
                   backgroundColor: Theme.of(context).primaryColor,
                   child: CircleAvatar(
                     radius: 6,
                     backgroundColor: widget.isOnline? Colors.yellowAccent: Colors.grey,
                   ),
                 )
               ],
             )
            ]))
      ],
    );
  }
}
