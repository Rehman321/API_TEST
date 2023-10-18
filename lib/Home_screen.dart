import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:api_test/my_services.dart';

import 'DescriptionScreen.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ApiServices.apifetch(),
          builder: (context,snapshot) {

            Map map = jsonDecode(snapshot.data);
            List mydata = map['tv_shows'];



            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: mydata.length,
                itemBuilder: (context, index) {


                  String? movieImage = mydata[index]['image_thumbnail_path'];
                  String? movieName = mydata[index]['name'];
                  String? movieStatus = mydata[index]['status'];
                  String? movieNetwork = mydata[index]['network'];
                  int movieId = mydata[index]['id'];



                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionScreen(movieID:movieId),));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Movie ID : $movieId")));
                    },
                    child:Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.red,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          //MovieAvatar
                          CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.black26,
                            backgroundImage: NetworkImage(movieImage!),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          //MovieDetails
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                child: Text(movieName!,overflow: TextOverflow.ellipsis,)),
                                Text(movieStatus!),
                                Text(movieNetwork!),




                            ],
                          )
                        ],
                      ),

                    ),

                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return Container();
          }),

    );
  }
}

