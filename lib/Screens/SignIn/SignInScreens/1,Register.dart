// ignore_for_file: file_names, prefer_const_constructors_in_immutables, unused_element, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_buyer/Screens/components/Loading.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../Services/Database/User/userDatabase.dart';
import '../../Components/Button.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = true;

  bool isLoading = false;
  String name = '';
  String email = '';
  DateTime birthday = DateTime.now();

  List gender = ["Male", "Female"];
  String? select;
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Colors.blue,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      }, currentTime: birthday, locale: LocaleType.en);
    }

    return loading == true
        ? Center(child: Loading())
        : Scaffold(
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
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
                        const Text('Register',
                            style: TextStyle(
                                fontSize: 38.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField('Name', 'name'),
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
                            child: birthdayWidget()),

                        TextField('Email', 'email'),
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
                                final user = FirebaseAuth.instance.currentUser;
                                final phoneNumber = user!.phoneNumber;
                                final userUid = user.uid;
                                UserDatabaseService().registerInformation(
                                    name,
                                    email,
                                    phoneNumber,
                                    userUid,
                                    select!,
                                    birthday);
                              }

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: isLoading
                                ? const Center(
                                    child: SpinKitCircle(
                                    color: Colors.black,
                                    size: 50.0,
                                  ))
                                : Button(text: 'Register')),
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

  Widget birthdayWidget() {
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
                        birthday.toString(),
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

  Widget TextField(var label, var value) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: TextFormField(
            // initialValue: inital,
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
}
