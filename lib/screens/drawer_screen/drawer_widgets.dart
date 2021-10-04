import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/drawr_fun.dart';




class DrawerWidgets extends StatefulWidget {

  DrawerWidgets(this.index, {this.key});

  final int? index;
  final Key? key;

  @override
  _DrawerWidgetsState createState() => _DrawerWidgetsState();
}

class _DrawerWidgetsState extends State<DrawerWidgets> {

  TextEditingController _newEmail = new TextEditingController();
  TextEditingController _newName = new TextEditingController();
  DrawerFunc _drawerFunc = new DrawerFunc();
  bool _isLoading = false;




  Widget changeUserName(BuildContext ctx){
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.black.withOpacity(0.68),Colors.black])),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
              'Change username',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.yellowAccent,
              fontFamily: 'french'
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          SizedBox(
            width: 300,
            child: TextField(

              controller: _newName,
              maxLength: 15,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold
              ),

              decoration: InputDecoration(
                filled: true,
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.yellowAccent.withOpacity(0.5),
                  fontWeight: FontWeight.bold
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Type your new username",
                fillColor: Colors.grey.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),

          SizedBox(
            width: 300,
            height: 40,
            child: FlatButton(

              highlightColor: Colors.yellowAccent,
              onPressed: () async{
                setState(() {
                  _isLoading = !_isLoading;
                });
                if(_newName.text.contains(new RegExp(r'[A-Z]')) || _newName.text.contains(new RegExp(r'[a-z]')) ||  _newName.text.contains(new RegExp(r'[أ-ي]'))){
                  await _drawerFunc.changeUserName(_newName.text,context);
                  Navigator.pop(context);
                }
                setState(() {
                  _isLoading = !_isLoading;
                });
              },
              color: Colors.yellowAccent.withOpacity(0.6),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(ctx).primaryColor,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }

  Widget changEmail(BuildContext ctx){
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.black.withOpacity(0.68),Colors.black])),


      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Change email',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.yellowAccent,
                fontFamily: 'french'
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          SizedBox(
            width: 300,
            child: TextField(
              controller: _newEmail,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold
              ),

              decoration: InputDecoration(
                filled: true,
                hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.yellowAccent.withOpacity(0.5),
                    fontWeight: FontWeight.bold
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.grey.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Type your new email",
                fillColor: Colors.grey.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 300,
            height: 40,
            child: FlatButton(

              highlightColor: Colors.yellowAccent,

              onPressed: () async{
                setState(() {
                  _isLoading = !_isLoading;
                });
                 await _drawerFunc.changeEmail(_newEmail.text).then((value) {
                   print(value);
                 });
                setState(() {
                  _isLoading = !_isLoading;
                });
              },

              color: Colors.yellowAccent.withOpacity(0.6),
              child: Text(
                'Submit',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(ctx).primaryColor
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ],
      ),
    );
  }

  Widget changeCodes(BuildContext ctx){

    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.black.withOpacity(0.68),Colors.black])),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 340,
            height: 180,
            child: Card(
              color: Colors.yellow.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              shadowColor: null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Change login code',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                        fontFamily: 'french'
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: FlatButton(

                      highlightColor: Colors.yellowAccent,
                      onPressed: () {
                      },
                      color: Colors.yellowAccent.withOpacity(0.6),
                      child: Text(
                        'Change',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(ctx).primaryColor
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 300,
            child: Divider(
              color: Colors.yellowAccent.withOpacity(0.5),
              thickness: 2,
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),

          SizedBox(
            width: 340,
            height: 180,

            child: Card(
              color:  Colors.yellow.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              shadowColor: null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Change invitation code',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellowAccent,
                        fontFamily: 'french'
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: FlatButton(

                      highlightColor: Colors.yellowAccent,
                      onPressed: () async{
                        setState(() {
                          _isLoading = !_isLoading;
                        });
                        await _drawerFunc.changeInvCode(
                            FirebaseAuth.instance.currentUser?.uid,
                            FirebaseAuth.instance.currentUser?.email,
                            context);
                        setState(() {
                          _isLoading = !_isLoading;
                        });
                      },
                      color: Colors.yellowAccent.withOpacity(0.6),
                      child: Text(
                        'Change invitation code',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(ctx).primaryColor
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ],
              ),

            ),
          ),

        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return Container(
        width: double.infinity,

        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.black.withOpacity(0.68),Colors.black])),

        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)
          ),
        ),
      );
    }
    if(widget.index == 1){
      return Scaffold(
        body: changeUserName(context),
      );
    }
    if(widget.index == 2){
      return Scaffold(
        body: changEmail(context),
      );
    }
    if(widget.index == 3){
      return Scaffold(
        body: changeCodes(context),
      );
    }
    return Scaffold(
      body: Container(),
    );
  }
}
