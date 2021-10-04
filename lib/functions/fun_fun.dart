import 'dart:math';

import 'package:flutter/material.dart';

class FunFun{

  String string = 'Hello';

   Color getColor(String _color){

    if(_color == 'red'){
      return Colors.red;
    }
    else if(_color == 'orange'){
      return Colors.orange;
    }
    else if(_color == 'blue'){
      return Colors.blue;
    }
    else if(_color == 'purple'){
      return Colors.purple;
    }
    else if(_color == 'pink'){
      return Colors.pinkAccent;
    }
    else if(_color == 'green'){
      return Colors.green;
    }
    else if(_color == 'brown'){
      return Colors.brown;
    }
    else if(_color == 'cyan'){
      return Colors.cyanAccent;
    }
    else if(_color == 'deepOrange'){
      return Colors.deepOrangeAccent;
    }

    return Colors.white;

  }

  String initColor(){

     List _list = ['red', 'orange', 'blue', 'purple', 'pink',
       'green', 'brown', 'cyan', 'deepOrange'];
     final _random = new Random();
     return _list[_random.nextInt(_list.length)];
  }


  bool isTyping(String msg){
     int? index1;
     int index2 = 0;
     if(msg.isEmpty)
       return false;
     for(int i = 0; i < msg.length; i++){
       if(msg[i] != ' ') {
         for(int j = msg.length - 1; j >= 0; j--){
           if(msg[j] != ' '){
             index1 = j+1;
             break;
           }
         }
         for(int j = 0; j < msg.length; j++){
           if(msg[j] != ' '){
             index2 = j;
             break;
           }
         }
         string = msg.substring(index2, index1);
         return true;
       }
     }
     return false;

  }


}