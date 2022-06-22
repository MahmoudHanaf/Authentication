import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Shared/components/components.dart';
import 'logIn/Shop_Login.dart';

class BoardingModel{
  final String image;
  final String title ;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});

}



class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var boardControler = PageController();
  List<BoardingModel> boarding =[
    BoardingModel(
      image: 'Images/m1.jpg',
      title: 'Need Groceries Now ?',
      body: 'Select wide range of products from fresh fruites',
    ),
    BoardingModel(
      image: 'Images/m2.jpg',
      title: 'Hassel free Payments',
      body: 'Select wide range of products from fresh fruits',
    ),
    BoardingModel(
      image: 'Images/m3.jpg',
      title: 'Fast Doorstep Delivery',
      body: 'Select wide range of products from fresh fruites',
    ),
  ];

  bool isLast =false ;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                navigateAndFinish(context,ShopLogIn());
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ),
        ],
      ),
      body: Padding(

        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardControler,
                onPageChanged: (int index){
                  if(index == boarding.length -1){
                    setState(() {
                      isLast =true;
                    });
                    print(" last");
                  }else{
                    setState(() {
                      isLast =false;
                    });
                    print("not last");
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>buildBoardingItem(boarding[index]) ,
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardControler,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                      activeDotColor: Colors.deepOrange,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast == true){
                        navigateAndFinish(context,ShopLogIn());
                      }else{
                        boardControler.nextPage(
                            duration: Duration(
                              microseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                ),
              ],
            ),



          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model)=> Column(
  children: [
    Expanded(
      child: Image(
        image: AssetImage("${model.image}"),

      ),
    ),
    SizedBox(
      height: 20,
    ),
    Text(
      "${model.title}",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),

    ),
    SizedBox(
      height: 20,
    ),
    Text(
      "${model.body}",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),

    ),
  ],
);
