import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Screens/components/Button.dart';
import 'package:provider/provider.dart';
import '../../../../Providers/AppInfo.dart';
import '../../../SignIn/SignInLogic/wrapper.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                height: (MediaQuery.of(context).size.height * 0.5) - 50,
                decoration: BoxDecoration(
                  color: appInformation.appColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(500.0),
                    bottomLeft: Radius.circular(500.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: (MediaQuery.of(context).size.height * 0.65),
              child: Text('We bring the market to you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: appInformation.appColor,
                      fontWeight: FontWeight.w400)),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.5) - 170,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/Asset 34.png',
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * 0.5) - 30,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/High-Res-Name.png',
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const Wrapper(),
                      ),
                    );
                  },
                  child: Button(text: 'Get Started'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
