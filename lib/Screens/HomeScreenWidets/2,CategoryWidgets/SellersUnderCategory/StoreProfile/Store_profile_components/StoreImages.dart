// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../Models/models.dart';
import '../../../../../../Shared/constants.dart';
import '../../../../../../Shared/customColors.dart';

class StoreImagesList extends StatefulWidget {
  SellerInformation seller;
  StoreImagesList({super.key, required this.seller});

  @override
  State<StoreImagesList> createState() => _StoreImagesListState();
}

class _StoreImagesListState extends State<StoreImagesList> {
  int ImageIndex = 0;
  late VideoPlayerController _controller;
  bool play = false;
  bool clear = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.seller.profileVideo == ''
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        : widget.seller.profileVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (play == false) {
      _controller.pause();
    }
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              clear = !clear;
            });
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Container(
              //image
              width: ScreenSize().ScreenWidth(context),
              height: ScreenSize().ScreenWidth(context),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: Colors.grey[200],
              ),
              child: widget.seller.profileImages[ImageIndex] != ''
                  ? ClipRRect(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.seller.profileImages[ImageIndex],
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
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
          ),
        ),
        Visibility(
          visible: play,
          child: GestureDetector(
            onTap: () {
              setState(() {
                clear = !clear;
              });
            },
            child: Center(
              child: widget.seller.profileVideo != ''
                  ? _controller.value.isInitialized
                      ? Container(
                          color: Colors.red,
                          width: ScreenSize().ScreenWidth(context),
                          height: ScreenSize().ScreenWidth(context),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        )
                      : Container()
                  : Container(),
            ),
          ),
        ),
        Visibility(
          visible: clear,
          child: Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              height: 100,
              alignment: Alignment.center,
              child: Center(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.seller.profileImages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          ImageIndex = index;
                          play = false;
                        });
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Visibility(
                                visible: index == 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (_controller.value.isPlaying) {
                                              _controller.pause();
                                              play = false;
                                            } else {
                                              _controller.play();
                                              _controller.setLooping(true);
                                              play = true;
                                            }
                                          });
                                        },
                                        child: Center(
                                          child: widget.seller.profileVideo != ''
                                              ? _controller.value.isInitialized
                                                  ? Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Container(
                                                            color: Colors.red,
                                                            width: 90,
                                                            height: 90,
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  _controller
                                                                      .value
                                                                      .aspectRatio,
                                                              child: VideoPlayer(
                                                                  _controller),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 0,
                                                          right: 0,
                                                          top: 0,
                                                          bottom: 0,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child: Container(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 90,
                                                              height: 90,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 0,
                                                          right: 0,
                                                          top: 0,
                                                          bottom: 0,
                                                          child: Icon(
                                                            size: 40,
                                                            play == false
                                                                ? FontAwesomeIcons
                                                                    .play
                                                                : FontAwesomeIcons
                                                                    .pause,
                                                            color:
                                                                CustomColors()
                                                                    .white,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Container(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        width: 90,
                                                        height: 90,
                                                        child: const Center(
                                                          child: SpinKitCircle(
                                                            color: Colors.white,
                                                            size: 25.0,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                              : Container(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: Container(
                                  //image
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                  child: widget.seller.profileImages[index] != ''
                                      ? ClipRRect(
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                widget.seller.profileImages[index],
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Center(
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                child: CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Colors.grey[300]!),
                                                    value: downloadProgress
                                                        .progress),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
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
                              ),

                              // floatingActionButton: FloatingActionButton(
                              //   onPressed: () {
                              //     setState(() {
                              //       _controller.value.isPlaying
                              //           ? _controller.pause()
                              //           : _controller.play();
                              //     });
                              //   },
                              //   child: Icon(
                              //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
