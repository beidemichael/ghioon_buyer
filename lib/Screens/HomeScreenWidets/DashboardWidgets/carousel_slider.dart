import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel_Slider extends StatefulWidget {
  const Carousel_Slider({super.key});

  @override
  State<Carousel_Slider> createState() => _Carousel_SliderState();
}

class _Carousel_SliderState extends State<Carousel_Slider> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final promo = Provider.of<List<CompanyPromo>>(context);

    return Center(
        child: Column(
      children: [
        CarouselSlider.builder(
            itemCount: promo.length,
            itemBuilder: ((context, index, realIndex) {
              print(promo);
              if (promo.length == 0) {
                return Container();
              } else {
                final image = promo[index].image;
                return buildImage(image, index);
              }
            }),
            options: CarouselOptions(
              height: ScreenSize().ScreenHeight(context) * 0.2,
              autoPlay: true,
              reverse: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              autoPlayInterval: Duration(seconds: 5),
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            )),
        SizedBox(
          height: 15,
        ),
        buildIndicator(promo),
      ],
    ));
  }

  Widget buildImage(String image, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      //color: Colors.grey,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        ),
        border: Border.all(
            width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
        color: CustomColors().white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            bottomLeft: Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      // child: Image.network(
      //   image,
      //   fit: BoxFit.cover,
      // ),
    );
  }

  Widget buildIndicator(var promo) => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: promo.length,
        effect: JumpingDotEffect(
            dotWidth: 12,
            dotHeight: 12,
            activeDotColor: CustomColors().blue,
            dotColor: CustomColors().grey),
      );
}
