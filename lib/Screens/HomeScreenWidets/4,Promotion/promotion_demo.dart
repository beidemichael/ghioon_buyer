import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PromotionsPage extends StatefulWidget {
  @override
  _PromotionsPageState createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  int _currentBigCarousel = 0;
  int _currentMediumCarousel = 0;
  int _currentSmallCarousel = 0;

  final List<String> _bigPromotions = [    'assets/undraw_web_shopping_re_owap.png',    'assets/undraw_shopping_app_flsj.png',    'assets/undraw_Social_bio_re_0t9u.png',  ];

  final List<String> _mediumPromotions = [    'assets/undraw_Social_bio_re_0t9u.png',    'assets/undraw_web_shopping_re_owap.png',    'assets/undraw_shopping_app_flsj.png',  ];

  final List<String> _smallPromotions = [    'assets/undraw_shopping_app_flsj.png',    'assets/undraw_Social_bio_re_0t9u.png',    'assets/undraw_web_shopping_re_owap.png',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promotions'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            _buildBigCarousel(),
            SizedBox(height: 8),
            _buildMediumCarousel(),
            SizedBox(height: 8),
            _buildSmallCarousel(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBigCarousel() {
    return Column(
      children: [
        Text(
          'Big Promotions',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        CarouselSlider(
          items: _bigPromotions.map((promotion) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  promotion,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                _currentBigCarousel = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _bigPromotions.map((promotion) {
            int index = _bigPromotions.indexOf(promotion);
            return Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _currentBigCarousel == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMediumCarousel() {
    return Column(
      children: [
        Text(
          'Medium Promotions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        CarouselSlider(
          items: _mediumPromotions.map((promotion) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  promotion,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 150,
),
),
);
}).toList(),
options: CarouselOptions(
height: 150,
enlargeCenterPage: true,
autoPlay: true,
autoPlayInterval: Duration(seconds: 3),
onPageChanged: (index, reason) {
setState(() {
_currentMediumCarousel = index;
});
},
),
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: _mediumPromotions.map((promotion) {
int index = _mediumPromotions.indexOf(promotion);
return Container(
width: 8,
height: 8,
margin: EdgeInsets.symmetric(horizontal: 2),
decoration: BoxDecoration(
shape: BoxShape.circle,
color: _currentMediumCarousel == index
? Colors.blue
: Colors.grey,
),
);
}).toList(),
),
],
);
}

Widget _buildSmallCarousel() {
return Column(
children: [
Text(
'Small Promotions',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 8),
CarouselSlider(
items: _smallPromotions.map((promotion) {
return Container(
margin: EdgeInsets.symmetric(horizontal: 8),
child: ClipRRect(
borderRadius: BorderRadius.circular(8),
child: Image.asset(
promotion,
fit: BoxFit.cover,
width: double.infinity,
height: 100,
),
),
);
}).toList(),
options: CarouselOptions(
height: 100,
enlargeCenterPage: true,
autoPlay: true,
autoPlayInterval: Duration(seconds: 2),
onPageChanged: (index, reason) {
setState(() {
_currentSmallCarousel = index;
});
},
),
),
Row(
mainAxisAlignment: MainAxisAlignment.center,
children: _smallPromotions.map((promotion) {
int index = _smallPromotions.indexOf(promotion);
return Container(
width: 8,
height: 8,
margin: EdgeInsets.symmetric(horizontal: 2),
decoration: BoxDecoration(
shape: BoxShape.circle,
color: _currentSmallCarousel == index
? Colors.blue
: Colors.grey,
),
);
}).toList(),
),
],
);
}
}
