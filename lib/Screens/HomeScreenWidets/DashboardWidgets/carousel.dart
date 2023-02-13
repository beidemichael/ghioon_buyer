import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:provider/provider.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    final promo = Provider.of<List<CompanyPromo>>(context);

  
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CarouselSlider(
                  items: promo.map((url) {
          return carosel_item(image: url.image);
        }).toList(),
                  options: CarouselOptions(
                   enlargeCenterPage: true,
        
                    height: ScreenSize().ScreenHeight(context) * 0.25,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.85,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.decelerate,
                  
                    enlargeFactor: 0.3,
                    
                    

                    //onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                  
                 
                  ),
    );
  }
}

class carosel_item extends StatelessWidget {
  const carosel_item({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                 image),
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
        );
  }
}