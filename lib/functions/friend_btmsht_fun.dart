import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FriendWidgetBtmshtFun{


  Future removeAllMyChat(String friendUid) async{

    String? _yourUid = FirebaseAuth.instance.currentUser?.uid;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs1 = [];
    List _catchIndex = [];

    await FirebaseFirestore.instance.collection('chat')
    .doc(_yourUid).collection('friends').doc(friendUid).collection('msg').get()
    .then((value) {
      docs = value.docs;
      print('First');
    });


    for(int i = 1; i < docs.length; i++){
      if(docs[i].get('userId') == _yourUid) {
        _catchIndex.add(docs[i].id.toString());
      }
    }
    print('Second');


    for(int i = 0; i < _catchIndex.length; i++){
      await FirebaseFirestore.instance.collection('chat')
          .doc(_yourUid).collection('friends').doc(friendUid).collection('msg')
          .doc(_catchIndex[i]).delete();

      await FirebaseFirestore.instance.collection('chat')
          .doc(friendUid).collection('friends').doc(_yourUid).collection('msg')
          .doc(_catchIndex[i]).delete();
    }
    await FirebaseFirestore.instance.collection('chat')
        .doc(_yourUid).collection('friends').doc(friendUid).collection('msg').get()
        .then((value) {
      docs1 = value.docs;
    });


    print('Third');


    if(docs1.length != 1) {
      String? _lastMsg;
      Timestamp? _time;

      await FirebaseFirestore.instance.collection('chat').doc(_yourUid)
          .collection('friends')
          .doc(friendUid).collection('msg').orderBy(
          'createdAt', descending: true).get()
          .then((value) {
        _lastMsg = value.docs[0].get('text');
        _time = value.docs[0].get('createdAt');
      });

      print('Fourth');

      await FirebaseFirestore.instance.collection('friends')
          .doc(friendUid).collection('uid')
          .doc(_yourUid).update({
        'createdAt': _time,
        'msg': _lastMsg,
        'isNewMsg': false,
      });

      print('Fifth');

      await FirebaseFirestore.instance.collection('friends')
          .doc(_yourUid).collection('uid')
          .doc(friendUid).update({
        'createdAt': _time,
        'msg': _lastMsg,
      });

      print('Thix');
    }
    else{
      await FirebaseFirestore.instance.collection('friends')
          .doc(friendUid).collection('uid')
          .doc(_yourUid).update({
        'msg': '',
        'isNewMsg': false,
      });

      await FirebaseFirestore.instance.collection('friends')
          .doc(_yourUid).collection('uid')
          .doc(friendUid).update({
        'msg': '',
      });


    }

  }


  Future removeFriend(String friendUid) async{
    String? _yourUid = FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance.collection('friends').doc(_yourUid).
    collection('uid').doc(friendUid).delete();

    await FirebaseFirestore.instance.collection('friends').doc(friendUid).
    collection('uid').doc(_yourUid).delete();
    
  }



}