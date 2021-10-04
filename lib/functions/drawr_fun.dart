import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kaito/functions/auth_fun.dart';
import 'package:kaito/providers/user_details.dart';
import 'package:provider/provider.dart';

class DrawerFunc{

  AuthFunc _authFunc = new  AuthFunc();



  Future changeEmail(String _email) async{
    try {
      await FirebaseAuth.instance.currentUser?.updateEmail(_email);
      return 'change success';

    } on FirebaseAuthException catch (e) {

      if (e.code == 'invalid-email') {
        return 'Invalid Email';
      } else if (e.code == 'email-already-in-use') {
        return 'Email already in use';
      }
    }
  }


  Future changeUserName(String _userName , BuildContext ctx) async{

    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
      'name': _userName
    });

    await Provider.of<UserDetails>(ctx, listen: false).getName();
    print('${Provider.of<UserDetails>(ctx, listen: false).name}');

  }

  Future changeInvCode(String? _uid, String? _email , BuildContext ctx) async{

    var _code = _authFunc.makeCode().join().toString();
    print(_code);
    await _authFunc.validCodeInv(_code);
    while (true) {
      if (_authFunc.isValidCodeInv) break;
    }

    await FirebaseFirestore.instance.collection('invCode').doc(Provider.of<UserDetails>(ctx, listen: false).invitationCode).delete();
    await FirebaseFirestore.instance.collection('invCode').doc(_code).set({
      'uid' : _uid,
      'email': _email
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .update({
      'invcode': _code
    });

    await Provider.of<UserDetails>(ctx, listen: false).getInvCode();

  }


}