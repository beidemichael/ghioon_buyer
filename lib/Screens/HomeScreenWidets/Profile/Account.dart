import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ghioon_buyer/Models/models.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Logic/UploadPhoto.dart';
import '../../../Services/Database/User/userDatabase.dart';
import '../../../Shared/customColors.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Shared/loading.dart';
import '../../Components/Button.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  String name = '';
  String email = '';
  String image = '';
  var imageFile;
  var uploadedPhoto;
  DateTime birthday = DateTime.now();

  List gender = ["Male", "Female"];
  String select = 'Male';
  Future pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      imageFile = imageTemporary;
    });
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: CustomColors().blue,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInformation>>(context);
    void whenScheduleUpDateTapped() {
      DatePicker.showDatePicker(context,
          // minTime: DateTime.now(),
          showTitleActions: true,
          theme: const DatePickerTheme(
              containerHeight: 400,
              itemStyle: TextStyle(color: Colors.black, fontSize: 18),
              doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
          onChanged: (date) {
        print('change $date in time zone ' +
            date.timeZoneOffset.inHours.toString());
      }, onConfirm: (date) {
        setState(() {
          birthday = date;
        });

        // Provider.of<Order>(context, listen: false).addTime(date);
        print('confirm $date');
      }, currentTime:  DateTime.fromMicrosecondsSinceEpoch(userInfo[0].birthday.microsecondsSinceEpoch), locale: LocaleType.en);
    }

    return userInfo.isEmpty
        ? Loading()
        : Scaffold(
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  AddImageContainer(
                    imageFile,
                    userInfo[0].image,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/Super Man_Monochromatic.png',
                        //   height: MediaQuery.of(context).size.height * .3,
                        // ),
                        const SizedBox(
                          height: 10,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        TextField(userInfo[0].userName, 'Name', 'name'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            addRadioButton(0, 'Male'),
                            addRadioButton(1, 'Female'),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {
                              whenScheduleUpDateTapped();
                            },
                            child: birthdayWidget(userInfo[0].birthday)),

                        TextField(userInfo[0].email, 'Email', 'email'),
                        const SizedBox(
                          height: 20,
                        ),
                        phoneWidget(),
                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              if (_formKey.currentState!.validate()) {
                                if (name == '') {
                                  name = userInfo[0].userName;
                                }
                                if (email == '') {
                                  email = userInfo[0].email;
                                }
                                if (select == '') {
                                  email = userInfo[0].gender;
                                }

                                final user = FirebaseAuth.instance.currentUser;
                                final phoneNumber = user!.phoneNumber;
                                final userUid = user.uid;
                                if (imageFile == null) {
                                  uploadedPhoto = userInfo[0].image;
                                } else {
                                  uploadedPhoto = await uploadImage(imageFile,
                                      user.uid.toString(), 'ProfilePic');
                                }
                                // ignore: prefer_conditional_assignment
                                if (birthday == DateTime.now()) {
                                  birthday = userInfo[0].birthday;
                                }

                                UserDatabaseService().updateUserInformation(
                                    name,
                                    email,
                                    phoneNumber,
                                    userUid,
                                    uploadedPhoto,
                                    select,
                                    birthday);
                              }

                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                            },
                            child: isLoading
                                ? const Center(
                                    child: SpinKitCircle(
                                    color: Colors.black,
                                    size: 50.0,
                                  ))
                                : Button(text: 'Update')),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget phoneWidget() {
    final user = FirebaseAuth.instance.currentUser;
    final phoneNumber = user!.phoneNumber;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 64,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Text(phoneNumber!,
                style: const TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 129, 129, 129),
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  Widget birthdayWidget(cloudBirthdate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 64,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(width: 1, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Birthday: ',
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  width: 20,
                ),
                Text(
                    DateFormat('MMM dd yyyy').format(
                      DateTime.parse(
                        DateTime.fromMicrosecondsSinceEpoch(cloudBirthdate.microsecondsSinceEpoch)
                        .toString(),
                      ),
                    ),
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 88, 88, 88),
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TextField(var inital, var label, var value) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: TextFormField(
            initialValue: inital,
            onChanged: (val) {
              setState(() {
                if (value == 'name') name = val;
                if (value == 'email') email = val;
              });
            },
            validator: (val) {
              if (val!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20.0,
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 20, top: 30, bottom: 10),
              labelText: label,
              focusColor: Colors.blue,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 20.0,
                  color: Colors.grey[800]),
              enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue.shade200)),
            ),
          ),
        ),
      ],
    );
  }

  Widget AddImageContainer(var localImage, var cloudImage) {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: CustomColors().darkBlue,
                // border:
                //     Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0), //or 15.0
                child: Container(
                  child: localImage != null
                      ? Image.file(
                          localImage!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: CustomColors().blue,
                            borderRadius: BorderRadius.circular(100),
                            // ignore: prefer_const_literals_to_create_immutables
                          ),
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          child: cloudImage != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Stack(
                                    children: [
                                      Container(
                                        //image
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: cloudImage != ''
                                            ? ClipRRect(
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: cloudImage,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.grey[
                                                                      300]!),
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
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
                                    ],
                                  ),
                                )
                              : const Icon(
                                  FontAwesomeIcons.solidUser,
                                  shadows: [],
                                  size: 80.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                        ),
                  // Image(image: AssetImage('assets/images/ima.png')),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: CustomColors().white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 5,
                      blurRadius: 8,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Icon(
                  FontAwesomeIcons.camera,
                  size: 20.0,
                  color: CustomColors().blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
