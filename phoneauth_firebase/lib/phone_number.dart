import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phoneauth_firebase/dashboard.dart';

class Phonenumber extends StatefulWidget {
  @override
  _PhonenumberState createState() => _PhonenumberState();
}

class _PhonenumberState extends State<Phonenumber> {

  TextEditingController cNope = TextEditingController();
  TextEditingController cOTP = TextEditingController();
  String sNope;
  String sOTP;
  String verificationId;

  Future<void> verifyPhone () async{

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verId){
      verificationId = verId;
      print(verificationId);
    };

    final PhoneCodeSent codeSent = (String verId, [int forceResendingToken]){
      verificationId = verId;
      // print(verificationId);
      // print(forceResendingToken);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e){
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }else{
        print(e);
      }
    };

    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential auth){
      print('sukses');
      // FirebaseAuth.instance.signInWithCredential(auth).then((UserCredential value){
      //   if(value.user != null){
      //     User user = value.user;
      //     print(user);
      //   }else{
      //     print('user not autorized');
      //   }
      // });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+62 ' + sNope,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );
  }

  void verifikasiOTP(){
    var auth = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: sOTP);
    FirebaseAuth.instance.signInWithCredential(auth).then((UserCredential value){
      if(value.user != null){
        User user = value.user;
        print(user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Dashboard()));
      }else{
        print('user not autorized');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tes OTP'),
      ),
      body: Center(
        child: ListView(
          children: [
            TextFormField(
              controller: cNope,
              onChanged: (value){
                sNope = cNope.text;
              },
              decoration: InputDecoration(
                hintText: 'Nomor HP'
              ),
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
              child: Center(
                child: Text('Kirim OTP', style: TextStyle(color: Colors.white),),
              ),
              color: Colors.green,
              onPressed: (){
                verifyPhone();
                print(sNope);
              }
            ),


            TextFormField(
              controller: cOTP,
              onChanged: (value){
                sOTP = cOTP.text;
              },
              decoration: InputDecoration(
                  hintText: 'Kode OTP'
              ),
              keyboardType: TextInputType.number,
            ),
            RaisedButton(
                child: Center(
                  child: Text('Verifikasi OTP', style: TextStyle(color: Colors.white),),
                ),
                color: Colors.green,
                onPressed: (){
                  verifikasiOTP();
                }
            )
          ],
        ),
      ),
    );
  }
}
