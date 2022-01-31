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
          padding: EdgeInsets.fromLTRB(Style.width / 12, 10, Style.width / 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.header('Search'),
              const SizedBox(height: 10),
              TypeAheadFormField(
                textFieldConfiguration: SimpleTextField.getTextFieldConfiguration(_controller),
                suggestionsCallback: (pattern) {
                  return search(pattern);
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (String suggestion) {
                  _controller.text = suggestion;
                  print('Selected ' + suggestion);
                },
                onSaved: (String? value) {
                  _selected = value!;
                  print('Selected ' + value);
                }
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.only(bottom: 20),
                  primary: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: const [
                    GenresBox(name: 'Strength', color: Colors.deepOrangeAccent, image: ''),
                    GenresBox(name: 'Flexibility', color: Colors.deepPurpleAccent, image: ''),
                    GenresBox(name: 'Balance', color: Colors.pink, image: ''),
                    GenresBox(name: 'Turnout', color: Colors.blueAccent, image: ''),
                    GenresBox(name: 'Kicks', color: Colors.redAccent, image: ''),
                    GenresBox(name: 'Jumps', color: Colors.deepOrangeAccent, image: ''),
                    GenresBox(name: 'Turns', color: Colors.deepPurpleAccent, image: ''),
                    GenresBox(name: 'Ballet', color: Colors.pink, image: ''),
                    GenresBox(name: 'Acrobatics', color: Colors.blueAccent, image: ''),
                    GenresBox(name: 'Jazz', color: Colors.redAccent, image: ''),
                  ],
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
