// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nynews/source/bloc/news/news_bloc.dart';
import 'package:nynews/source/bloc/news/news_event.dart';

class SearchBox extends StatefulWidget {
  final String? searchQuery;
  final Function(String)? callback;
  const SearchBox({
    Key? key,
    this.searchQuery,
    this.callback,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final List<String> _options = [
    '1',
    '7',
    '30',
  ];
  String? _selectedPeriod;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          children: [
            DropdownButton<String>(
              value: _selectedPeriod,
              items: _options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedPeriod = value;
                  context.read<NewsBloc>().add(NewsDataEvent(
                      section: 'all-sections', period: _selectedPeriod));
                });
              },
              hint: const Text('period'),
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  // setState(() {
                  widget.callback!(value);

                  // });

                  // setState(() {
                  //   widget.searchQuery == value.toString();
                  // });
                },
              ),
            ),
            // Image.asset('assets/images/icon_apple_blue.png'),
          ],
        ),
      ),
    );
  }
}
