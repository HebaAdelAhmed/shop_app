import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/shop_login_screen.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});

}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(title: 'Browse the application' , image: 'assets/image/pic_1.png' , body: 'You can browse the application easily'),
    BoardingModel(title: 'Your favourites' , image: 'assets/image/pic_2.png' , body: 'Add more products to your favourites'),
    BoardingModel(title: 'Search for products' , image: 'assets/image/pic_3.png' , body: 'Easily browse categories and search for products'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text(
              'SKIP',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: (){
              submit();
            },
          ),
        ],
        // backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == boarding.length -1){
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController ,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else{
                      boardingController.nextPage(
                          duration: Duration(
                              milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boarding) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(boarding.image),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        boarding.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        boarding.body,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );

  void submit(){
    CacheHelper.saveData(key:'onBoarding' , value: true).then((value){
      if(value){
        navigateAndFinish(
            context: context ,
            widget: ShopLoginScreen()
        );
      }
    });

  }
}
