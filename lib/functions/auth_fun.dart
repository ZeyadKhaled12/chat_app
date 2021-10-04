import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AuthFunc {
  bool isValidCode = true;
  bool isValidCodeInv = true;

  String _signInWord = '';
  FunFun _funFun = new FunFun();


  //singUP function
  Future signUpFunc(String _email) async {
    var _code = makeCode().join().toString();
    await validCode(_code);
    while (true) {
      if (isValidCode) break;
    }

    try {


      final _auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _code);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.user?.uid)
          .set({
        'email': _email,
        'code': _code,
        'name': 'Fresh kid',
        'imageUrl': '',
        'color': _funFun.initColor(),
        'firstTime': 'true',
        'online': true
      });

      await FirebaseFirestore.instance
          .collection('codes')
          .doc(_code)
          .set({'uid': _auth.user?.uid, 'email': _email, 'firstTime': 'true'});

      await sendEmail(
          name: '',
          email: 'kaitocon99@gmail.com',
          toEmail: _email,
          subject: 'Kaito',
          message: 'Your code is $_code'
      );





      await makeCodeInvite(_auth.user?.uid, _email);

      await FirebaseFirestore.instance.collection('favGroup').doc(_auth.user?.uid).set({

      });

      await FirebaseFirestore.instance.collection('friends').doc(_auth.user?.uid).set({
      });
      
      await FirebaseFirestore.instance.collection('friendRqst').doc(_auth.user?.uid).collection('number').doc().set({
        'number': 0
      });

      await FirebaseAuth.instance.signOut();

      return 'success';




    } on FirebaseAuthException catch (e) {

      if (e.code == 'invalid-email') {
        return 'invalid email';
      } else if (e.code == 'email-already-in-use') {
        return 'email already in use';
      }
    }
  }


  //send email
  Future sendEmail({
   required String name,
    required String toEmail,
   required String email,
   required String subject,
   required String message
  }) async{
    final serviceId = 'service_hbqnvjs';
    final templateId = 'template_6pdxnwl';
    final userId = 'user_3KXjovq9D3GcgOSjN9c4M';


    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final body =  {
    'service_id': serviceId,
    'template_id': templateId,
    'user_id': userId,
    'template_params' : {
    'user_name': name,
    'user_email': email,
    'user_subject': subject,
    'user_message': message,
      'to_email': toEmail
    },
    };
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        "Content-Type": "application/json"
      },

      body: jsonEncode(body)

    );

  }





  List makeCode() {
    var r = new Random();
    String string = 'AaBbcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    String string2 = '@#%^&*|}';
    List list = [];
    list.add(string[r.nextInt(51)]);
    list.add(string2[r.nextInt(8)]);
    list.add(r.nextInt(10));
    list.add(string[r.nextInt(51)]);
    list.add(r.nextInt(10));
    list.add(string2[r.nextInt(8)]);
    List code = [];
    List randomlist = list;
    var random;
    int count = 6;
    for (int i = 0; i < 6; i++) {
      random = new Random().nextInt(count);
      code.add(randomlist[random]);
      count--;
      randomlist.removeAt(random);
    }
    return code;
  }

  //valid email
  bool validEmail(String _email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
    return emailValid;
  }

  Future<void> validCode(String _code) async {
    await FirebaseFirestore.instance
        .collection('codes')
        .doc(_code)
        .get()
        .then((value) {
      if (value.exists) {
        isValidCode = false;
      }
    });
  }

  Future<void> validCodeInv(String _code) async {
    await FirebaseFirestore.instance
        .collection('invCode')
        .doc(_code)
        .get()
        .then((value) {
      if (value.exists) {
        isValidCodeInv = false;
      }
    });
  }

  //sign in
  Future<String> signIn(String _code, BuildContext ctx) async {

    await Provider.of<UserDetails>(ctx, listen: false).isFirstTime(_code);

    await FirebaseFirestore.instance
        .collection('codes')
        .doc(_code)
        .get()
        .then((value) async{
      if (value.exists) {
        final email = value.data()?['email'];
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: _code);

      } else {
        _signInWord = 'NotExist';
      }
    });
    return _signInWord;
  }


  //make code invite
  makeCodeInvite(String? _uid, String _email) async{
    var _code = makeCode().join().toString();
    await validCodeInv(_code);
    while (true) {
      if (isValidCodeInv) break;
    }
    FirebaseFirestore.instance.collection('invCode').doc(_code).set({
      'uid' : _uid,
      'email': _email
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .update({
      'invcode': _code
    });
  }






}
