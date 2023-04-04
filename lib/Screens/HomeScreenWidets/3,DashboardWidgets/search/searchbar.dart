import 'package:flutter/material.dart';
import 'package:ghioon_buyer/Providers/language_provider.dart';
import 'package:ghioon_buyer/Shared/customColors.dart';
import 'package:ghioon_buyer/Shared/language.dart';
import 'package:provider/provider.dart';
class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
     var languageprov = Provider.of<LanguageProvider>(context);
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              enabled: false,
              controller: _controller,
              decoration: InputDecoration(
                hintText: Language().search[languageprov.LanguageIndex],
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors().grey,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.mic,
                    color: CustomColors().black,
                  ),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
