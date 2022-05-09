import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      home: HomePage(),
    );
  }
}




class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  Future<dynamic> fetchCount ()async{

// get API used http
    const url = 'https://countriesnow.space/api/v0.1/countries/info?returns=currency,flag,unicodeFlag,dialCode';
    final res =await http.get(Uri.parse(url)) ;

    if(res.statusCode == 200 ){
      var obj = json.decode(res.body);
      return await obj;

    }else {
      return Exception('Error') ;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Data Used API'),
      ),
      body: FutureBuilder(
        future:fetchCount() ,
        builder: (conn ,AsyncSnapshot snap ){
          if(snap.hasData){
          return  ListView.builder(
            itemCount: snap.data['data'].length,
              itemBuilder: (conn  , index)=> Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  Text(snap.data['data'][index]['name'] ?? '') ,
                  Text(snap.data['data'][index]['currency'] ?? '' ) ,
                ]),
                SizedBox(
                  width: 15,
                ),
              SvgPicture.network(
                  snap.data['data'][index]['flag'] ?? '',
                width: 50,
              )
              //  Text(snap.data['data'][0]['flag']) ,
              ],
            )) ;
          }else {
            return Text('wait') ;
          }


        } ,
      )
    );
  }
}
