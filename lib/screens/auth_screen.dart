import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaito/functions/auth_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isChangeScreen = true;
  String _hint = 'Email';
  AuthFunc _authFunc = new AuthFunc();
  bool _isLoading = false;
  final _x = GlobalKey<ScaffoldState>();





  snackBar(String msg, double size){

    final sBr = SnackBar(
      content: Text(
          msg,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: size,
          color: Colors.yellowAccent
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
      ),

    );

    return _x.currentState?.showSnackBar(sBr);

  }



  /*
  Future dialog(String msg, double fontSize){
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // <-- Radius
      ),
      backgroundColor: Colors.yellowAccent,
      title: Text(msg,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold
          )),
      content: Container(
        height: 80,
        child: Column(
          children: <Widget>[
            Divider(
              thickness: 3,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 130,
                      child:  FlatButton(
                        highlightColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () async{
                          SystemChrome.setEnabledSystemUIOverlays([]);
                          Navigator.of(context).pop();
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text('Ok', style:
                        TextStyle(
                            color: Colors.white,
                            fontSize: 22
                        )),
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );

    return showDialog(
        context: context,
        builder: (ctx) {
          return alert;
          //return Opacity(child: alert , opacity: 0.699999,);
        });

  }

   */

/*
  Widget signInScreen() {
    TextEditingController _codeController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 140,
          child: Card(
              color: Theme.of(context).accentColor,
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    'SIGN IN',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 48,
                        fontFamily: 'impact'),
                  ),
                  Padding(padding: EdgeInsets.all(50)),
                  Icon(Icons.arrow_drop_down_circle, size: 60)
                ],
              )),
        ),
        Padding(padding: EdgeInsets.all(20)),
        Text('Write your code',
            style: TextStyle(
                fontSize: 40,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 300,
          child: PinCodeTextField(
            controller: _codeController,
            appContext: context,
            length: 5,
            onChanged: (value) {},
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              inactiveColor: Colors.white.withOpacity(0.5),
              activeColor: Colors.white,
              activeFillColor: Colors.white,
              selectedColor: Colors.white,
            ),
            textStyle:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 30),
            keyboardType: TextInputType.number,
            onCompleted: (value) {
              SystemChrome.setEnabledSystemUIOverlays([]);
            },
          ),
        ),
        Padding(padding: EdgeInsets.all(124)),
        SizedBox(
          height: 80,
          width: double.infinity,
          child: FlatButton(
            splashColor: Colors.black,
            color: Theme.of(context).accentColor,
            onPressed: () {
              setState(() {
                _isChangeScreen = !_isChangeScreen;
                SystemChrome.setEnabledSystemUIOverlays([]);
              });
            },
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(6)),
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 30,
                    fontFamily: 'impact',
                  ),
                ),
                Padding(padding: EdgeInsets.all(80)),
                Icon(Icons.arrow_forward, size: 50)
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget signUpScreen() {
    TextEditingController _emailController = TextEditingController();
    String _hint = 'Email';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: 140,
          child: Card(
              color: Theme.of(context).accentColor,
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    'SIGN UP',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 48,
                        fontFamily: 'impact'),
                  ),
                  Padding(padding: EdgeInsets.all(50)),
                  Icon(Icons.arrow_drop_down_circle, size: 60)
                ],
              )),
        ),
        Padding(padding: EdgeInsets.all(20)),
        Text('Write your email',
            style: TextStyle(
                fontSize: 40,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold)),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 290,
          child: TextField(
            onTap: () {
              setState(() {
                _hint = '';
              });
            },
            onSubmitted: (value) {
              setState(() {
                _hint = 'Email';
                SystemChrome.setEnabledSystemUIOverlays([]);
              });
            },
            cursorColor: Theme.of(context).accentColor,
            textAlign: TextAlign.center,
            controller: _emailController,
            style: TextStyle(
                fontSize: 30,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                hintText: _hint,
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 25),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.white.withOpacity(0.8)),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      new BorderSide(color: Colors.white.withOpacity(0.5)),
                )),
          ),
        ),
        Padding(padding: EdgeInsets.all(30)),
        SizedBox(
          width: 300,
          height: 66,
          child: RaisedButton(
            splashColor: Colors.black,
            onPressed: () {},
            color: Theme.of(context).accentColor,
            child: Text(
              'Sign up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
        Padding(padding: EdgeInsets.all(65)),
        SizedBox(
          height: 80,
          width: double.infinity,
          child: FlatButton(
            splashColor: Colors.black,
            color: Theme.of(context).accentColor,
            onPressed: () {
              setState(() {
                _isChangeScreen = true;
                SystemChrome.setEnabledSystemUIOverlays([]);
              });
            },
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(6)),
                Text(
                  'SIGN IN',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 30,
                    fontFamily: 'impact',
                  ),
                ),
                Padding(padding: EdgeInsets.all(80)),
                Icon(Icons.arrow_forward, size: 50)
              ],
            ),
          ),
        )
      ],
    );
  }

 */

  Widget signInScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(50)),
        Text(
          'KAITO',
          style: TextStyle(
              fontSize: 58,
              color: Colors.yellowAccent,
              fontFamily: 'itali',
              fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(50)),
        Text('Write your code',
            style: TextStyle(
                fontSize: 34,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.bold,
                fontFamily: 'french')),
        Padding(padding: EdgeInsets.all(15)),
        SizedBox(
          width: 300,
          child: PinCodeTextField(
            appContext: context,
            length: 6,
            onChanged: (value) {},
            cursorColor: Colors.yellowAccent,
            pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                inactiveColor: Colors.white.withOpacity(0.5),
                activeColor: Colors.white,
                activeFillColor: Colors.white,
                selectedColor: Colors.white,
                borderWidth: 0.5),
            textStyle: TextStyle(color: Colors.yellowAccent, fontSize: 30),
            //keyboardType: TextInputType.number,
            onCompleted: (value) async{

              setState(() {
                _isLoading = !_isLoading;
              });
              Provider.of<UserDetails>(context, listen: false).isLoginFunc();
              await _authFunc.signIn('%93|Po', context).then((value) async{

                if(value == 'NotExist'){
                  snackBar('This code not exist!', 22);
                  SystemChrome.setEnabledSystemUIOverlays([]);
                }
                else{

                }
              });
              setState(() {
                _isLoading = !_isLoading;
              });



            },
          ),
        ),
        Padding(padding: EdgeInsets.all(5)),
        SizedBox(
          width: 100,
          height: 100,
          child: FlatButton(
            highlightColor: Colors.yellowAccent,
            onPressed: () {
              setState(() {
                _isChangeScreen = !_isChangeScreen;
                SystemChrome.setEnabledSystemUIOverlays([]);
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            child: Icon(
              Icons.arrow_right,
              size: 80,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(3)),
        Text('New Account',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget signUpScreen() {
    TextEditingController _emailController = new TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(50)),
        Text(
          'KAITO',
          style: TextStyle(
              fontSize: 58,
              color: Colors.yellowAccent,
              fontFamily: 'itali',
              fontWeight: FontWeight.bold),
        ),
        Padding(padding: EdgeInsets.all(20)),
        Text('Write your Email',
            style: TextStyle(
                fontSize: 34,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontWeight: FontWeight.bold,
                fontFamily: 'french')),
        Padding(padding: EdgeInsets.all(15)),
        //textfieldOfEmail.
        SizedBox(
          width: 290,
          child: TextField(
            onSubmitted: (value) async{
              setState(() {
                _isLoading = !_isLoading;
              });
              if (_emailController.text != '') {

                Provider.of<UserDetails>(context, listen: false).isSignUpFunc();
                await _authFunc.signUpFunc(_emailController.text).then((value) {
                  if(value == 'success'){
                    snackBar('You have successfully signed up.\n Check your email to know your code.', 18);
                  }
                  if(value == 'invalid email') {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                   snackBar('This is Invalid Email!', 24);
                  }
                  else if(value == 'email already in use') {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                    snackBar('Email already in use.', 24);
                  }
                });
              }
              else{
                print('You must write your Email');
              }
              setState(() {
                _isLoading = !_isLoading;
              });
            },
            cursorColor: Colors.yellowAccent,
            textAlign: TextAlign.center,
            controller: _emailController,
            style: TextStyle(
                fontSize: 30,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                hintText: _hint,
                hintStyle: TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                focusedBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.yellowAccent,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.yellowAccent,
                  ),
                )),
          ),
        ),
        Padding(padding: EdgeInsets.all(8)),
        //signButton
        SizedBox(
          width: 300,
          height: 40,
          child: FlatButton(
            highlightColor: Colors.yellowAccent,
            onPressed: () async{
              setState(() {
                _isLoading = !_isLoading;
              });
              if (_emailController.text != '') {

                Provider.of<UserDetails>(context, listen: false).isSignUpFunc();
                await _authFunc.signUpFunc(_emailController.text).then((value) {
                  if(value == 'success'){
                    snackBar('You have successfully signed up.\n Check your email to know your code.', 18);
                  }
                  if(value == 'invalid email') {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                    snackBar('This is Invalid Email!', 24);
                  }
                  else if(value == 'email already in use') {
                    SystemChrome.setEnabledSystemUIOverlays([]);
                    snackBar('Email already in use.', 24);
                  }
                });
              }
              else{
                print('You must write your Email');
              }
              setState(() {
                _isLoading = !_isLoading;
              });
            },
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            child: Text(
              'Sign up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 100,
          height: 100,
          child: FlatButton(
            highlightColor: Colors.yellowAccent,
            focusColor: Colors.yellowAccent,
            onPressed: () {
              setState(() {
                _isChangeScreen = !_isChangeScreen;
                SystemChrome.setEnabledSystemUIOverlays([]);
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            child: Icon(
              Icons.arrow_right,
              size: 80,
              color: Theme.of(context).textTheme.bodyText1?.color,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(3)),
        Text('LogIn',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _x,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [Colors.black54, Theme.of(context).primaryColor])),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Opacity(
                opacity: 0.19,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(_isChangeScreen
                      ? 'assets/images/signUpPic.jpg'
                      : 'assets/images/signInPic.jpg'),
                ),
              ),
              SingleChildScrollView(
                child: _isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(160)),
                          CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.yellowAccent)
                          )
                        ],
                      )
                    : _isChangeScreen
                        ? signUpScreen()
                        : signInScreen(),
              )
            ],
          )),
    );
  }
}

/*

 */
