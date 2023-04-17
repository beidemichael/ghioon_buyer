import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  int _selectedLanguageIndex = 0;
  List<String> _languages = [
    'English',
    'አማርኛ',
  ];

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AppBar(
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(Language().language[languageprov.LanguageIndex],
                      style: TextStyle(
                          fontSize: 30.0,
                          color: CustomColors().white,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              // excludeHeaderSemantics: true,
              backgroundColor: CustomColors().blue,
              // automaticallyImplyLeading: false,
              elevation: 5,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              iconTheme: IconThemeData(color: CustomColors().white)),
        ),
      ),
      body: ListView.builder(
        itemCount: _languages.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 224, 224, 224)),
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                selected: languageprov.LanguageIndex == index,
                leading: Icon(Icons.language),
                trailing: languageprov.LanguageIndex == index
                    ? Icon(
                        Icons.check,
                        color: CustomColors().blue,
                      )
                    : null,
                title: Text(_languages[index]),
                onTap: () async {
                  setState(() {
                    languageprov.LanguageIndex = index;
                  });
                  await languageprov.saveSelectedLanguageIndex(index);
                   Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
