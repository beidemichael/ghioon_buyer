import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../Models/models.dart';
import '../../../Shared/customColors.dart';
import 'package:video_player/video_player.dart';

Carousel50(List<Promotion> oldPromotion, width, height) {
  List<Promotion> promotion = [];
  for (int i = 0; i < oldPromotion.length; i++) {
    if (oldPromotion[i].screenRealestate == '50')
      promotion.add(oldPromotion[i]);
  }
  return Container(
    color: Colors.white,
    height: width * .5 + 20,
    child: Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: width * .5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 1200),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: promotion.map<Widget>((i) {
          print('promotion  50:');
          return Builder(
            builder: (BuildContext context) {
              return i.screenRealestate == '50'
                  ? Container(
                      width: width,
                      height: width * .5,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      // decoration: BoxDecoration(color: Colors.amber),
                      child: i.isImage
                          ? PhotoContainer(i.image)
                          : VideoContainer(width, height, i.video))
                  : Container(
                      color: Colors.blue,
                    );
            },
          );

          // else {
          //   return Builder(
          //     builder: (BuildContext context) {
          //       return Container();
          //     },
          //   );
          // }
        }).toList(),
      ),
    ),
  );
}

Carousel100(List<Promotion> oldPromotion, width, height) {
  List promotion = [];
  for (int i = 0; i < oldPromotion.length; i++) {
    if (oldPromotion[i].screenRealestate == '100')
      promotion.add(oldPromotion[i]);
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: CarouselSlider(
      options: CarouselOptions(
        // initialPage: 0,
        height: height * 0.6,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 1500),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: promotion.map<Widget>((i) {
        print('promotion  100:');
        return Builder(
          builder: (BuildContext context) {
            return i.screenRealestate == '100'
                ? Container(
                    width: width,
                    height: height,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    // decoration: BoxDecoration(color: Colors.red),
                    child: i.isImage ? PhotoContainer(i.image) : Container())
                : Container(
                    color: Colors.blue,
                  );
          },
        );
      }).toList(),
    ),
  );
}

Widget Carousel25(List<Promotion> oldPromotion, width, height) {
  List<Promotion> promotion = [];
  for (int i = 0; i < oldPromotion.length; i++) {
    if (oldPromotion[i].screenRealestate == '25')
      promotion.add(oldPromotion[i]);
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: CarouselSlider(
      options: CarouselOptions(
        // initialPage: 0,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        height: width * 0.3,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
        autoPlayAnimationDuration: const Duration(milliseconds: 600),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: promotion.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return i.screenRealestate == '25'
                ? Container(
                    width: width * 0.3,
                    height: width * 0.25,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: i.isImage ? PhotoContainer(i.image) : Container())
                : Container(
                    color: Colors.blue,
                  );
          },
        );
      }).toList(),
    ),
  );
}

PhotoContainer(image) {
  return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: CustomColors().darkBlue,
        border: Border.all(width: 1, color: CustomColors().blue),
        //  boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withOpacity(0.9),
        //       spreadRadius: 2,
        //       blurRadius: 3,
        //       offset: Offset(0, 2), // changes position of shadow
        //     ),
        //   ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: image != ''
          ? ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                //image
                width: 149,
                height: 149,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: image != ''
                    ? ClipRRect(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: image,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.grey[300]!),
                                  value: downloadProgress.progress),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.newspaper_rounded,
                          size: 10,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            )
          : const Icon(
              FontAwesomeIcons.userLarge,
              size: 80.0,
              color: Colors.white,
            ));
}

VideoContainer(width, height, video) {
  late VideoPlayerController _controller;
  _controller = VideoPlayerController.network(video == ''
      ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      : video)
    ..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      _controller.play();
      _controller.setLooping(true);
    });
  return Container(
    // color: Colors.red,
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: CustomColors().blue),
    ),
    width: width,
    height: height,
    child: AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    ),
  );
}
