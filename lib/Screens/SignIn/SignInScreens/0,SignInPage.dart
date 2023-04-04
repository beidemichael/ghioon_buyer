// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_function_declarations_over_variables, avoid_print

import 'dart:async';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Screens/components/storeList.dart';
import 'package:ghioon_buyer/Shared/constants.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
import '../../../Providers/AppInfo.dart';
import '../../../Services/PhoneAuth.dart';
import '../../HomeScreenWidets/5,Profile/SettingPages/Select_language.dart';
import '../../components/Button.dart';
import '../SignInDialogBoxes/error_signingin.dart';
import '../SignInDialogBoxes/expired_code_blury_dialog.dart';
import '../SignInDialogBoxes/phonenumber_dialog.dart';
import '../SignInDialogBoxes/too_many_times.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isLoading = false;
  String phoneCode = "+251";
  String phoneNumber = "";
  String wholePhoneNumber = "";
  String otpCode = "";
  String loginState = "";
  bool otpVisible = false;
  bool resendVisible = false;

  Timer? _timer;
  int _start = 59;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    // ignore: unnecessary_new
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (mounted) {
        setState(
          () {
            if (_start == 2) {
              _showExpiredDialog(context);
              otpVisible = false;
            }
            if (_start == 1) {}
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        );
      }
    });
  }

  _showExpiredDialog(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
        };
    BlurryDialog alert = BlurryDialog(okCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => AppInformation(),
          child: alert,
        );
      },
    );
  }

  _showErrorDialog(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
        };
    ErrorSigningInBlurryDialog alert = ErrorSigningInBlurryDialog(okCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => AppInformation(),
          child: alert,
        );
      },
    );
  }

  _tooManyTimesTried(BuildContext context) {
    VoidCallback okCallBack = () => {
          // Navigator.of(context).pop(),
          _timer!.cancel(),
          if (mounted)
            {
              setState(() {
                otpVisible = false;
              }),
            }
        };
    TooManyTrialsBlurryDialog alert = TooManyTrialsBlurryDialog(okCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => AppInformation(),
          child: alert,
        );
      },
    );
  }

  _showPhoneDialog(BuildContext context) {
    VoidCallback toManyTimes = () => {
          _tooManyTimesTried(context),
        };
    VoidCallback yesCallBack = () => {
          // Navigator.of(context).pop(),
          PhoneAuthServices(wholePhoneNumber: wholePhoneNumber)
              .submitPhoneNumber(toManyTimes),
          startTimer(),
          print('submit'),
          setState(() {
            otpVisible = true;
            _start = 59;
          }),
        };
    VoidCallback noCallBack = () => {
          Navigator.of(context).pop(),
        };
    PhoneBlurryDialog alert =
        PhoneBlurryDialog(wholePhoneNumber, yesCallBack, noCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeNotifierProvider(
          create: (context) => AppInformation(),
          child: alert,
        );
      },
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      phoneCode = countryCode.toString();
    });

    print("New Country selected: $countryCode");
  }

  @override
  Widget build(BuildContext context) {
    final appInformation = Provider.of<AppInformation>(context);
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   width: 300,
                //   height: 50,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   const LanguageSelectionPage()),
                //         );
                //       },
                //       child: ListTile(
                //         leading: Icon(Icons.language),
                //         title: Text(languageprov
                //             .languagesList[languageprov.LanguageIndex]),
                //       )),
                // ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const LanguageSelectionPage()),
                      );
                    },
                    child: StoreList(
                        FontAwesomeIcons.lock,
                        languageprov.languagesList[languageprov.LanguageIndex],
                        ScreenSize().ScreenWidth(context))),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/undraw_Modern_design_re_dlp8.png',
                    height: MediaQuery.of(context).size.height * .3,
                  ),
                  GestureDetector(
                    onTap: () {
                      // PhoneAuthServices.signOut();
                    },
                    child: Text(
                        Language().enter_phone[languageprov.LanguageIndex],
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // ignore: prefer_const_constructors
                  Visibility(
                    visible: !otpVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                          Language().receive6digit[languageprov.LanguageIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Visibility(
                    visible: otpVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          Language().enterOtp[languageprov.LanguageIndex] +
                              ' ' +
                              wholePhoneNumber,
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: otpVisible,
                          child: _start >= 10
                              ? Text(
                                  "$_start",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      color: Colors.grey[500]),
                                )
                              : Text(
                                  "$_start",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.0,
                                      color: Colors.grey[500]),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    visible: !otpVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 50),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: CountryCodePicker(
                                onChanged: _onCountryChange,
                                initialSelection: '+251',
                                favorite: const ['+251', 'ETH'],
                                textStyle: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    phoneNumber = val.trim();
                                    // widget.location.phoneNumber =
                                    //     phoneCode + phoneNumber.trim();
                                  });
                                },
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: Language()
                                      .phonenumber[languageprov.LanguageIndex],
                                  focusColor: Colors.orange[900],
                                  labelStyle: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: otpVisible,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextFormField(
                        validator: (val) => val!.length != 6
                            ? Language().mustbe6[languageprov.LanguageIndex]
                            : null,
                        textAlign: TextAlign.center,
                        onChanged: (val) {
                          setState(() {
                            otpCode = val;
                          });
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500

                            // decorationColor: Colors.white,
                            ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 20),

                          //Label Text/////////////////////////////////////////////////////////
                          hintText: '_  _  _  _  _  _',
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 30.0,
                              fontWeight: FontWeight.w300

                              // decorationColor: Colors.white,
                              ),
                          // labelText: Texts.PHONE_NUMBER_LOGIN,
                          focusColor: Colors.orange[900],

                          /* hintStyle: TextStyle(
                                      color: Colors.orange[900]
                                      ) */
                          ///////////////////////////////////////////////

                          //when it's not selected////////////////////////////
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 189, 189, 189))),
                          ////////////////////////////////

                          ///when textfield is selected//////////////////////////
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                color: appInformation.appColor,
                              )),

                          ////////////////////////////////////////
                          ///
                          ///
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 83, 80))),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 239, 83, 80))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 100,
                  ),

                  GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (otpVisible) {
                            VoidCallback codeInvalid =
                                () => {_showErrorDialog(context)};
                            VoidCallback cancelTimer = () => {_timer!.cancel()};
                            PhoneAuthServices(otpCode: otpCode).submitOTP(
                                otpCode,
                                wholePhoneNumber,
                                codeInvalid,
                                cancelTimer);
                            print('otp');
                          }
                          if (!otpVisible) {
                            wholePhoneNumber = " ";
                            wholePhoneNumber = phoneCode + phoneNumber.trim();
                            _showPhoneDialog(context);
                          }
                        }
                      },
                      child: isLoading
                          ? const Center(
                              child: SpinKitCircle(
                              color: Colors.black,
                              size: 50.0,
                            ))
                          : Button(
                              text: !otpVisible
                                  ? Language()
                                      .submit[languageprov.LanguageIndex]
                                  : Language()
                                      .login[languageprov.LanguageIndex])),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
