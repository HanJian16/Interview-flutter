import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_flutter/providers/list_provider.dart';
import 'package:provider/provider.dart';

class CustomDropDownDialog extends StatefulWidget {
  const CustomDropDownDialog({
    super.key,
  });

  @override
  State<CustomDropDownDialog> createState() => _CustomDropDownDialogState();
}

class _CustomDropDownDialogState extends State<CustomDropDownDialog> {
  List cities = [];
  Map selectCity = {};
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool pass = false;

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ListProvider>();

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 40,
          left: 20,
          right: 20),
      child: Stack(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add City',
                  ),
                  onChanged: searchCityForName,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add a description',
                  ),
                  maxLines: 3,
                  onChanged: (String value) {
                    if (value.isNotEmpty && cityController.text.isNotEmpty) {
                      setState(() {
                        pass = true;
                      });
                    } else {
                      setState(() {
                        pass = false;
                      });
                    }
                  },
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: pass ? () => getTimeOfCity(chatProvider) : null,
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                      backgroundColor: WidgetStateProperty.all(
                          pass ? Colors.blue : Colors.grey),
                    ),
                    child: const Text(
                      'Save City',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          if (cities.isNotEmpty)
            Positioned(
              top: 65,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 180,
                color: const Color.fromARGB(255, 241, 241, 241),
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(cities[index]['LocalizedName']),
                      onTap: () {
                        setState(() {
                          selectCity = cities[index];
                          cityController.text = selectCity['LocalizedName'];
                          cities = [];
                          if (descriptionController.text.isNotEmpty) {
                            setState(() {
                              pass = true;
                            });
                          } else {
                            setState(() {
                              pass = false;
                            });
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  getTimeOfCity(chatProvider) async { 
    try {
      const apikey = '3L3b0b9Jy0UXwWqedqL5Cc7DhqzqcOYL';
      Uri url = Uri.parse(
          'http://dataservice.accuweather.com/currentconditions/v1/${selectCity['Key']}?apikey=$apikey');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List cityInfo = json.decode(response.body);
        final Map dataList = {
          'city': selectCity['LocalizedName'],
          'description': descriptionController.text,
          'temperature': cityInfo[0]['Temperature']['Metric']['Value'],
          'date': cityInfo[0]['LocalObservationDateTime'],
        };

        chatProvider.addItem(dataList);

        if(context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      }
    } catch (e) {
      print('Handle error: $e');
    }
  }

  void searchCityForName(String value) async {
    try {
      if (value.isNotEmpty) {
        const apikey = '3L3b0b9Jy0UXwWqedqL5Cc7DhqzqcOYL';
        Uri url = Uri.parse(
            'http://dataservice.accuweather.com/locations/v1/cities/autocomplete?apikey=$apikey&q=$value');

        var response = await http.get(url);

        if (response.body != 'null' &&
            response.body.isNotEmpty &&
            response.statusCode == 200) {
          setState(() {
            cities = json.decode(response.body);
          });
        } else {
          setState(() {
            cities = [];
          });
        }
      } else {
        setState(() {
          cities = [];
        });
      }
    } catch (e) {
      print('Handle error: $e');
    }
  }
}
