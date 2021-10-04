import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ntp/ntp.dart';

class ChatFun {
  late bool isValidCode = false;

  sortListView(
      List<dynamic> _bool, List<dynamic> _names, List<dynamic> _colors) {
    List _listOfTrue = [];
    List _listOfTrue2 = [];

    List _listOfName = [];
    List _listOfName2 = [];

    List _listOfColors = [];
    List _listOfColors2 = [];

    for (int i = 0; i < _bool.length; i++) {
      _listOfTrue.add(_bool[i]);
      _listOfName.add(_names[i]);
      _listOfColors.add(_colors[i]);
    }

    for (int i = 0; i < _listOfTrue.length; i++) {
      if (_listOfTrue[i] == true) {
        _listOfTrue2.add(_listOfTrue[i]);
        _listOfName2.add(_listOfName[i]);
        _listOfColors2.add(_listOfColors[i]);
        _listOfTrue[i] = null;
        _listOfColors[i] = null;
        _listOfName[i] = null;
      }
    }

    _listOfTrue.removeWhere((element) => element == null);
    _listOfName.removeWhere((element) => element == null);
    _listOfColors.removeWhere((element) => element == null);

/*
    print(_listOfTrue2);
    print(_listOfTrue);
    print('*************************************');
    print(_listOfName2);
    print(_listOfName);
    print('*************************************');
    print(_listOfColors2);
    print(_listOfColors);

 */
    _bool = new List.from(_listOfTrue2)..addAll(_listOfTrue);
    _names = new List.from(_listOfName2)..addAll(_listOfName);
    _colors = new List.from(_listOfColors2)..addAll(_listOfColors);
    /*
    print(_bool);
    print(_colors);
    print(_names);

     */
  }

  Future <String> sendInvite(String _code) async {
    String? friendUid;
    bool _isFriendExist = true;

    print(isValidCode);
    await validInvCode(_code);
    print(isValidCode);
    if (isValidCode) {
      print('\n\n\n\n\n\n\nExist code\n\n\n\n\n\n\n');
      await FirebaseFirestore.instance
          .collection('invCode')
          .doc(_code)
          .get()
          .then((value) {
        friendUid = value.data()?['uid'];
        print(friendUid);
      });
      if(friendUid == FirebaseAuth.instance.currentUser?.uid){
        return  'you can\'t invite yourself!';
      }
      else {


        await FirebaseFirestore.instance.collection('friendRqst').doc(friendUid).collection('uid').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
          value.exists?_isFriendExist = false: _isFriendExist = true;
        });

        /////////////////
        if(_isFriendExist) {
          await FirebaseFirestore.instance
              .collection('friendRqst')
              .doc(friendUid).collection('uid').doc(
              '${FirebaseAuth.instance.currentUser?.uid}').set({});


          String? docKey;

          int number = await FirebaseFirestore.instance.collection('friendRqst')
              .doc(friendUid).collection('number').get()
              .then((value) {
            print('\n\n\n\n\n\n${value.docs[0].get('number')}\n\n\n\n\n\n\n');
            docKey = value.docs[0].id;
            return value.docs[0].get('number');
          });


          print('\n\n\n\n\n\n\n$docKey\n\n\n\n\n\n\n\n');
          print('\n\n\n\n\n\n\n$number\n\n\n\n\n\n\n\n');

          await FirebaseFirestore.instance
              .collection('friendRqst')
              .doc(friendUid).collection('number').doc(docKey).update({
            'number': number + 1
          });
        }
///////////////


      }
    }
    else {
      return 'NotExist inv code';
    }
    return '';
  }

  validInvCode(String _code) async {
    await FirebaseFirestore.instance
        .collection('invCode')
        .doc(_code)
        .get()
        .then((value) {
      if (value.exists) {
        print('lol');
        isValidCode = true;
      } else {
        isValidCode = false;
      }
    });
  }


  sendNewMsg(String? friendUid  , String msg) async{
    var _userUid = FirebaseAuth.instance.currentUser?.uid;

    DateTime _myTime;
    _myTime = await NTP.now();
    String _docKey = 'msg' + _myTime.toString();


    await FirebaseFirestore.instance.collection('chat').
    doc(_userUid).collection('friends').
    doc(friendUid).collection('msg').doc(_docKey).set({
      'text': msg,
      'createdAt': _myTime,
      'userId': _userUid
    });


    await FirebaseFirestore.instance.collection('chat')
        .doc(friendUid).collection('friends')
        .doc(_userUid).collection('msg').doc(_docKey).set({
      'text': msg,
      'createdAt': _myTime,
      'userId': _userUid,
    });

    await FirebaseFirestore.instance.collection('friends')
        .doc(_userUid).collection('uid')
        .doc(friendUid).update({
      'createdAt': _myTime,
      'msg': msg,
    });

    await FirebaseFirestore.instance.collection('friends')
        .doc(friendUid).collection('uid')
        .doc(_userUid).update({
      'createdAt': _myTime,
      'msg': msg,
      'isNewMsg': true,
    });
  }



  Future deleteMsg({

    @required String? friendUid,
    @required String? msgUid,
  }) async{
    String? yourId = FirebaseAuth.instance.currentUser?.uid;
    Timestamp? time2;   String? lastMsg;   Timestamp? time;

    await FirebaseFirestore.instance.collection('chat').doc(yourId).collection('friends')
        .doc(friendUid).collection('msg').orderBy('createdAt',  descending: true).get().then((value) {
      time2 = value.docs[0].get('createdAt');
    });
    await FirebaseFirestore.instance.collection('chat').doc(yourId).collection('friends')
    .doc(friendUid).collection('msg').doc(msgUid).delete();

    await FirebaseFirestore.instance.collection('chat').doc(friendUid).collection('friends')
        .doc(yourId).collection('msg').doc(msgUid).delete();


    await FirebaseFirestore.instance.collection('chat').doc(yourId).collection('friends')
        .doc(friendUid).collection('msg').orderBy('createdAt',  descending: true).get().then((value) {
           lastMsg = value.docs[0].get('text');
           time = value.docs[0].get('createdAt');
    });
    print(lastMsg);
    print(time);
    print(time2);

    await FirebaseFirestore.instance.collection('friends')
        .doc(friendUid).collection('uid')
        .doc(yourId).update({
      'createdAt': time,
      'msg': time == time2? lastMsg: 'Deleted Message',
    });

    await FirebaseFirestore.instance.collection('friends')
        .doc(yourId).collection('uid')
        .doc(friendUid).update({
      'createdAt': time,
      'msg': time == time2? lastMsg: 'Deleted Message',
    });

  }






}
