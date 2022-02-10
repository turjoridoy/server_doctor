
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:server_doctor/styles/colors.dart';
import 'package:server_doctor/views/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {


    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "images/logo.png",
                      height: 150,
                      // color: Colors.black,
                    ),
                    SizedBox(height: 20,),
                    Text("Server Doctor",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: MyColors.primaryColor),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
