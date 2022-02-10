import 'dart:async';
import 'dart:io';

import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../model/ip.dart';
import '../styles/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Ip> ipList = [];
  int timeout = 5;
  bool loading = true;



  @override
  void initState() {
    super.initState();

    // ipList.add(new Ip(address: "aci-bd.com",status: false));
    ipList.add(new Ip(address: "192.168.101.173",status: false));
    ipList.add(new Ip(address: "192.168.100.44",status: false));
    ipList.add(new Ip(address: "192.168.100.183",status: false));
    ipList.add(new Ip(address: "192.168.101.85",status: false));
    ipList.add(new Ip(address: "192.168.101.89",status: false));
    ipList.add(new Ip(address: "192.168.101.63",status: false));
    onStartPage();

  }


  Future<void> onStartPage() async {


    connectivityChecker(ipList).then((value){
      setState(() {
        print(value[2].status);
        ipList = value;
        loading = false;
      });
    });
  }
  

  Future<List<Ip>> connectivityChecker(ipList) async {
    for(int i = 0 ; i < ipList.length; i++ ) {
      try {
        http.Response response = await http.get(Uri.parse("http://${ipList[i].address}")).timeout(Duration(seconds: timeout));
        print("Response: ${response.statusCode}");
        if (response.statusCode == 200 || response.statusCode ==404) {
          setState(() {
            ipList[i].status = true;
          });
        } else {
          setState(() {
            ipList[i].status = false;
          });
        }
      } on TimeoutException catch (e) {
        print('Timeout Error: $e');
      } on SocketException catch (e) {
        print('Socket Error: $e');
      } on Error catch (e) {
        print('General Error: $e');
      }
    }


    return ipList;
  }

  Future<void> _pullRefresh() async {
    onStartPage();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: MyColors.primaryColor,
          leading: InkWell(
              onTap:() => _scaffoldKey.currentState?.openDrawer(),
              child: Icon(Icons.menu, color: MyColors.white)
          ),
          title: Text("Server Doctor", style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: MyColors.white), textAlign: TextAlign.left,),
        ),
        body:  RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: loading == true ? Center(child: CircularProgressIndicator(color: MyColors.primaryColor,),): ListView.builder(
                itemCount: ipList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: MyColors.primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)
                            ),
                          ),
                          child: ipList[i].status == true? Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_circle_up,
                                    color: MyColors.primaryColor,
                                    size: 30,
                                  ),
                                  SizedBox(width:10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${ipList[i].address}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18,color: MyColors.black),),
                                      SizedBox(height:4,),
                                      Text("Status: ACTIVE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: MyColors.primaryColor),),
                                    ],
                                  ),
                                ],
                              )
                          ):
                          Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_circle_down,
                                    color: MyColors.secondaryColor,
                                    size: 30,
                                  ),
                                  SizedBox(width:10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${ipList[i].address}",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 18,color: MyColors.black),),
                                      SizedBox(height:4,),
                                      Text("Status: Not Active",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: MyColors.secondaryColor),),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),

                      ],
                    ),
                  );
                }
            ),
          ),
        )
    );
  }

}
