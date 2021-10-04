
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaito/functions/fun_fun.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';


class UserDetails with ChangeNotifier{

  FunFun _funFun = new FunFun();

  String? _name;
  String _email = '';
  String? _invitationCode;
  String _loginCode = '';
  bool _isSignUp = false;
  Color? _color;
  String? _firstTime;
  bool _isDelete = false;








  String? get name{
    return _name;
  }



  bool get isDelete{
    return _isDelete;
  }

  String? get firstTime{
    return _firstTime;
  }

  String get loginCode{
    return _loginCode;
  }

  Color? get color{
    return _color;
  }

  String get email{
    return _email;
  }

  String? get invitationCode{
    return _invitationCode;
  }

  bool get isSignUp{
    return _isSignUp;
  }


  Future<void> getUsers() async{



    _name =  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['name'];
    });

    _color =_funFun.getColor(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['color'];
    }));

    _email = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['email'];
    });

    _invitationCode = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['invcode'];
    });

    _loginCode  = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['code'];
    });

    notifyListeners();
  }



  Future getName() async{
    _name =  await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['name'];
    });
    notifyListeners();
  }



  Future getColor() async{
    _color = _funFun.getColor(await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['color'];
    }));
    notifyListeners();
  }



  Future getEmail() async{
    _email = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['email'];
    });
    notifyListeners();
  }

  Future getInvCode() async{
    _invitationCode = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['invcode'];
    });
    notifyListeners();
  }

  Future getLoginCode() async{
     _loginCode  = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      return value.data()?['code'];
    });
     notifyListeners();
  }




    isSignUpFunc(){
    _isSignUp = true;
    notifyListeners();
  }


  void isLoginFunc(){
    _isSignUp = false;
    notifyListeners();
  }


   Future<void> isFirstTime( String _code) async{
    _firstTime =await FirebaseFirestore.instance
        .collection('codes')
        .doc(_code)
        .get().then((value) => value.data()?['firstTime']);
    print('\n\n\n\n\n\n\n\n$_firstTime\n\n\n\n\n\n');
    notifyListeners();

  }

  void changeIsDelete(){
    _isDelete = !_isDelete;
    notifyListeners();
  }

  void changeIsDeleteFalse(){
    _isDelete = false;
    notifyListeners();
  }



















}

//Provider.of<Auth>(context, listen: false).getPrices();