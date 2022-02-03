import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taneo/components/app_text.dart';
import 'package:taneo/components/app_textfield.dart';
import 'package:taneo/util/style.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _controller = TextEditingController();
  String _selected = '';

  List<String> searchList = [
    'Legs (Strength)',
    'Core (Strength)',
    'Hands (Strength)',
    'Back (Strength)',
    'Feet (Strength)',
    'Legs (Flexibility)',
    'Feet (Flexibility)',
    'Back (Flexibility)',
    'Shoulder (Flexibility)',
    'Balance',
    'Turnout',
    'Kicks',
    'Jumps',
    'Turns',
    'Ballet',
    'Acrobatics',
    'Jazz',
  ];

  List<String> search(String s) {
    s = s.toLowerCase();
    return searchList.where((element) => element.toLowerCase().contains(s)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(Style.width / 12, Platform.isAndroid ? 30 : 10, Style.width / 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.header('Search'),
              const SizedBox(height: 10),
              TypeAheadFormField(
                textFieldConfiguration: SimpleTextField.getTextFieldConfiguration(_controller, () {
                  setState(() {});
                }),
                suggestionsCallback: (pattern) {
                  return search(pattern);
                },
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.antiAlias,
                ),
                itemBuilder: (context, String suggestion) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(suggestion),
                      ),
                      Divider(thickness: 1, color: Colors.grey.shade300, height: 0),
                    ],
                  );
                },
                noItemsFoundBuilder: (context) {
                  return const ListTile(
                    title: Text('No results found', textAlign: TextAlign.center),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    _controller.text = suggestion;
                  });
                },
                onSaved: (String? value) {
                  setState(() {
                    _selected = value!;
                  });
                }
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.only(bottom: 20),
                  primary: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  children: const [
                    GenresBox(name: 'Strength', color: Colors.deepOrangeAccent, image: 'strength'),
                    GenresBox(name: 'Flexibility', color: Colors.deepPurpleAccent, image: 'flexibility'),
                    GenresBox(name: 'Balance', color: Colors.pink, image: 'balance'),
                    GenresBox(name: 'Turnout', color: Colors.blueAccent, image: 'turnout'),
                    GenresBox(name: 'Kicks', color: Colors.redAccent, image: 'kicks'),
                    GenresBox(name: 'Jumps', color: Colors.deepOrangeAccent, image: 'jumps'),
                    GenresBox(name: 'Turns', color: Colors.deepPurpleAccent, image: 'turns'),
                    GenresBox(name: 'Ballet', color: Colors.pink, image: 'ballet'),
                    GenresBox(name: 'Acrobatics', color: Colors.blueAccent, image: 'acrobatics'),
                    GenresBox(name: 'Jazz', color: Colors.redAccent, image: 'jazz'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
    );
  }
}

class GenresBox extends StatefulWidget {
  const GenresBox({
    Key? key,
    required this.name,
    required this.color,
    required this.image,
  }) : super(key: key);

  final String name;
  final Color color;
  final String image;

  @override
  _GenresBoxState createState() => _GenresBoxState();
}

class _GenresBoxState extends State<GenresBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tapped ' + widget.name);
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: AppText.header(widget.name, Style.white, 0.9),
            ),
            if (widget.image.isNotEmpty) Positioned(
              bottom: 15,
              right: -15,
              child: Transform.rotate(
                angle: 0.2,
                child: Image.asset('assets/search_icons/' + widget.image + '.png', height: 90),
              ),
            )
          ],
        ),
      ),
    );
  }
}
