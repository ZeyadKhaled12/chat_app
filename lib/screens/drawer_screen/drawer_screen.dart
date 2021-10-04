import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/auth_fun.dart';
import 'package:kaito/functions/drawr_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/drawer_screen/drawer_widgets.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  DrawerFunc _drawerFunc = new DrawerFunc();
  bool _isLoading = false;
  AuthFunc _authFunc = new AuthFunc();

  function(String title) async {
    if (title == 'Change username') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DrawerWidgets(1)));
    } else if (title == 'Change email') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DrawerWidgets(2)));
    } else if (title == 'Change your codes') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DrawerWidgets(3)));
    } else if (title == 'Log out') {
      await FirebaseAuth.instance.signOut();
    }
  }

  Widget listTile(String title, Icon icon, double fontSize) {
    return ListTile(
      trailing: icon,
      onTap: () => function(title),
      selected: true,
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget expansionTile(String title, Icon icon, double fontSize) {
    
    
    return ExpansionTile(
      trailing: icon,
      children: <Widget>[
        _isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor))
            : FlatButton(
                highlightColor: Colors.yellowAccent,
                onPressed: () async {
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
                color: Theme.of(context).primaryColor,
                //Colors.yellowAccent.withOpacity(0.6),
                child: Text(
                  'Change invitation code',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.yellowAccent),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
      ],
      title: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
    
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      color: Colors.yellowAccent,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16)),

            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: CircleAvatar(
                    backgroundColor: Provider.of<UserDetails>(context, listen: false).color,
                    radius: 38,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 15,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.yellowAccent,
                  ),
                )
              ],
            ),

            Padding(padding: EdgeInsets.all(5)),
            Text(
              '${Provider.of<UserDetails>(context, listen: true).name}',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'french'),
            ),
            Text(
              '${Provider.of<UserDetails>(context, listen: false).email}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontFamily: 'french'),
            ),
            Text(
              'Your invitation code: ${Provider.of<UserDetails>(context, listen: false).invitationCode}',
              style: TextStyle(
                  fontSize: 21,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),
            listTile(
                'Change username',
                Icon(Icons.drive_file_rename_outline,
                    color: Theme.of(context).primaryColor, size: 30),
                20),
            expansionTile(
                'Change your codes',
                Icon(Icons.qr_code,
                    color: Theme.of(context).primaryColor, size: 30),
                20),
            Padding(padding: EdgeInsets.all(6)),
            Divider(color: Theme.of(context).primaryColor, thickness: 1),

            FlatButton(
                onPressed: () async {
                  await FirebaseFirestore.instance.collection('users').
                  doc(FirebaseAuth.instance.currentUser?.uid).update({
                    'online': false
                  });
                  print('looooooooooooool');
                  await FirebaseAuth.instance.signOut();
                  /*
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => AuthScreen()));

                       */
                },
                child: Row(
                  children: <Widget>[
                    Text('Log out',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 60)),
                    Icon(Icons.logout,
                        color: Theme.of(context).primaryColor, size: 30)
                  ],
                )),

            //listTile('Log out', Icon(Icons.logout, color: Theme.of(context).primaryColor, size: 30), 30),
          ],
        ),
      ),
    ));
  }
}
