import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:translator_deepl/widgets/Inherited/language_scope.dart';
import 'package:translator_deepl/widgets/translate_screen/country_list.dart';

class LanguageChange extends StatefulWidget {
  const LanguageChange({Key? key}) : super(key: key);

  @override
  _LanguageChangeState createState() => _LanguageChangeState();
}

class _LanguageChangeState extends State<LanguageChange> {
  final _langConroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ColoredBox(
              color: const Color.fromRGBO(143, 128, 231, 1),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          IconButton(
                            color: Colors.black,
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/main'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 40, top: 5),
                      child: TextField(
                        controller: _langConroller,
                        cursorWidth: 3,
                        cursorRadius: const Radius.circular(6),
                        cursorHeight: 20,
                        cursorColor: Colors.purple,
                        decoration: const InputDecoration(
                          hintText: 'Поиск языка',
                          constraints:
                              BoxConstraints(maxHeight: 50, minHeight: 50),
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Flexible(
              child: ValueListenableBuilder(
                valueListenable: _langConroller,
                builder: (context, TextEditingValue text, _) {
                  return LanguageList(
                    countries: Country.country
                        .where(
                          (element) => element['name']!
                              .toLowerCase()
                              .contains(text.text.toLowerCase()),
                        )
                        .toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LanguageList extends StatefulWidget {
  const LanguageList({Key? key, required this.countries}) : super(key: key);
  final List<Map<String, String>> countries;

  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  @override
  Widget build(BuildContext context) {
    log(widget.countries.toString());
    return ListView.builder(
        itemCount: widget.countries.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {
              LanguageScope.of(context)
                  .changeCurrentLang(widget.countries[index]['name']!),
              LanguageScope.of(context)
                  .changeTargetLang(widget.countries[index]['code']!),
              Navigator.pop(context)
            },
            child: ListTile(
              tileColor: Colors.purple[50],
              title: Text(
                widget.countries[index]['name']!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          );
        });
  }
}
