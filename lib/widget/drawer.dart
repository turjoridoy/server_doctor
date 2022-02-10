import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:server_doctor/views/homepage.dart';

import '../styles/colors.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Container(
                    child:  Container(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.home, size: 60,color: MyColors.white,),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.primaryColor),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  Spacer(),
                  Text("ACI SERVER DOCTOR",style: TextStyle(fontSize: 12,color: Colors.white),),
                ],
              ),
            ),
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: ListTile(
                //tileColor: MyColors.secondaryColor.withOpacity(0.3),
                leading: Icon(Icons.account_balance,color: Colors.grey,),
                title: Text('Server PC'),
              ),
            ),

            InkWell(
              onTap:(){
              },
              child: ListTile(
                //tileColor: MyColors.secondaryColor.withOpacity(0.3),
                leading: Icon(Icons.dashboard,color: Colors.grey,),
                title: Text('Other Servers'),
              ),
            ),
            InkWell(
              onTap:(){
              },
              child: ListTile(
                //tileColor: MyColors.secondaryColor.withOpacity(0.3),
                leading: Icon(Icons.dashboard,color: Colors.grey,),
                title: Text('Available Voucher'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
