import 'dart:convert';

import 'package:api_test/my_services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DescriptionScreen extends StatefulWidget {

  int movieID;


  DescriptionScreen({required this.movieID});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState(idMovie: movieID);
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  int idMovie;


  _DescriptionScreenState({required this.idMovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiServices.apifetchdesc(idMovie),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {

            Map map = jsonDecode(snapshot.data);

            String movieName = map['tvShow']['name'];
            String movieDescription = map['tvShow']['description'];
            String movieImage = map['tvShow']['image_thumbnail_path'];

            List moviePictures = map['tvShow']['pictures'];

            return Column(
              children: [

                SizedBox(height: 40,),

                Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(movieImage))
                  ),
                ),
                SizedBox(height: 20,),

                CarouselSlider.builder(
                    itemCount: moviePictures.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: double.infinity,
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(moviePictures[index]))
                        ),
                      );
                    }, options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: true,
                    height: 150,
                    autoPlayInterval: Duration(milliseconds: 2500),
                    autoPlayCurve: Curves.bounceInOut
                )),

                Text(movieName,style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),),
                Text(movieDescription),
              ],
            );
          }

          if (snapshot.hasError) {
            return Icon(Icons.error,size: 24,color: Colors.red,);
          }

          return Container();

        },),
    );
  }
}
