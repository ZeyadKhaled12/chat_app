import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:kaito/screens/auth_screen.dart';
import 'package:kaito/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseAuth.instance.signInWithEmailAndPassword(email: 'l@l.com', password: '3^U0&U');


  runApp(
    ChangeNotifierProvider(
      create: (_) => UserDetails(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget{

  int numTab = 0;
  void changeTab(){
    numTab = 1;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{



  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    print('\n\n\n\nBackGround InitState\n\n\n\n');
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
    print('\n\n\n\nBackGround Dispoose\n\n\n\n');
  }


  Future funWhileClosed() async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
      'online': false
    });
  }

  Future funWhileOpen() async{
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
      'online': true
    });
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.inactive ||
       state == AppLifecycleState.detached) return;
    final isBackground = state == AppLifecycleState.paused;

    if(isBackground){
      funWhileClosed();
    }
    else{
      funWhileOpen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, snapShot){
        if(snapShot.hasData){




          if(Provider.of<UserDetails>(context, listen: false).isSignUp){
            return AuthScreen();
          }

          /*
          if(Provider.of<UserDetails>(context, listen: false).firstTime == 'true'){
            return SignUpNext();
          }

           */


          return HomeScreen();
        }
        else{
          return AuthScreen();
        }
      }),
      theme: ThemeData(
        accentColor: Colors.yellowAccent,
        primaryColor: Color(0XFF111111),
        cardColor: Color(0XFF070707),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white.withOpacity(0.8)
          )
        )
      ),
    );
  }
}


