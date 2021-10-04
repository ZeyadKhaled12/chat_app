
import 'package:flutter/material.dart';
import 'package:kaito/functions/chat_fun.dart';
import 'package:pin_code_fields/pin_code_fields.dart';





class InviteScreen extends StatefulWidget {
  @override
  _InviteScreenState createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {

  ChatFun _chatFun = new ChatFun();
  bool _isLoading = false;




  Future dialog(String msg, double size){
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40), // <-- Radius
      ),
      backgroundColor: Colors.yellowAccent,
      title: Text(msg,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: size,
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
              height: 7,
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
        builder: (context) {
          return Opacity(child: alert , opacity: 0.699999,);
        });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading?
      Container(
        width: double.infinity,
        height:  double.infinity,

        color: Colors.yellowAccent,
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)
          )
        ),
      ):
      Container(
        width: double.infinity,
        height:  double.infinity,

        color: Colors.yellowAccent,
        child:
        SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(60)),
              Text('Write the invitation code',
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'french')),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                width: 300,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {
                  },
                  //_chatFun.sendInvite(value);
                  cursorColor: Colors.yellowAccent,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      inactiveColor: Theme.of(context).primaryColor.withOpacity(0.4),
                      activeColor: Theme.of(context).primaryColor,
                      selectedColor: Theme.of(context).primaryColor,
                      borderWidth: 1.6),
                  textStyle: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),
                  //keyboardType: TextInputType.number,
                  onCompleted: (value) async{
                    setState(() {
                      _isLoading = !_isLoading;
                    });
                    await _chatFun.sendInvite('H5*0z*').then((value) async{
                      if(value == 'NotExist inv code'){
                        dialog('This code not exist', 24);
                      }
                      else if(value == 'you can\'t invite yourself!') {
                        dialog('You can\'t invite yourself!', 20);
                      }
                      else{
                        setState(() {
                          _isLoading = !_isLoading;
                        });
                        await dialog('Your invitation have been sent successfully', 18).then((value) {
                          Navigator.of(context).pop();
                        });

                      }
                    });
                    setState(() {
                      _isLoading = !_isLoading;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
