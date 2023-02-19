import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Screens/HomeScreenWidets/ProfileWidgets/DeliveryAddresses/DeliveryAddressWidgets/adressWidgets/adress_after_map.dart';

import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../../Shared/loading.dart';
import '../../../../components/back.dart';
import 'adressWidgets/add_button.dart';
import 'package:geolocator/geolocator.dart';
import 'adressWidgets/place_your_adress_at_the_center.dart';

class MapAddress extends StatefulWidget {
  const MapAddress({super.key});

  @override
  State<MapAddress> createState() => _MapAddressState();
}

class _MapAddressState extends State<MapAddress> {
  GoogleMapController? _controller;
  static LatLng? _initialPosition;
  Map<MarkerId, Circle> circleA = <MarkerId, Circle>{};
  LatLng? _lastMapPosition;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    setState(() {
      loading = true;
    });
    var _locationData;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _locationData = await Geolocator.getCurrentPosition();
    _initialPosition =
        LatLng(_locationData.latitude!, _locationData.longitude!);
    _lastMapPosition = _initialPosition;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  afterAdress(BuildContext context, double? latitude, double? longitude) {
    final User user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    VoidCallback closeCallBack = () => {
          Navigator.of(context).pop(),
        };
    AddressAddBlurDialog alert = AddressAddBlurDialog(
      userUid: uid,
      latitude: latitude!,
      longitude: longitude!,
      // close: closeCallBack,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: [
            _initialPosition == null
                ? Loading()
                : GoogleMap(
                    mapType: MapType.hybrid,
                    tiltGesturesEnabled: false,
                    onCameraMove: _onCameraMove,
                    initialCameraPosition: CameraPosition(
                      tilt: 0,
                      bearing: 0,
                      target: _initialPosition!,
                      zoom: 19,
                    ),
                    circles: Set<Circle>.of(circleA.values),
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      setState(() {
                        circleA[MarkerId('a')] = Circle(
                            circleId: CircleId("A"),
                            center: LatLng(_initialPosition!.latitude,
                                _initialPosition!.longitude),
                            radius: 30,
                            fillColor: CustomColors().blue.withOpacity(0.4),
                            strokeColor: Colors.transparent,
                            strokeWidth: 0);
                      });
                    },
                  ),
            Center(
                child: _initialPosition == null
                    ? Container()
                    : Icon(
                        FontAwesomeIcons.locationDot,
                        color: CustomColors().blue,
                        size: 40,
                      )),
            Positioned(
              top: 40,
              left: 20,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Back()),
            ),
            Positioned(
                top: 40, right: 20, child: PlaceYourAdressAtTheCenter()),
            Positioned(
              bottom: 60,
              right: 0,
              left: 0,
              child: _initialPosition == null
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        if (_lastMapPosition != null) {
                          afterAdress(context, _lastMapPosition?.latitude,
                              _lastMapPosition?.longitude);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 640, 40, 30),
                        child: Container(
                          width: 250,
                          height: 50,
                          decoration: BoxDecoration(
                            color: CustomColors().blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Text(
                                'Pick Location',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
