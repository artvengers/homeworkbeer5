
// import 'package:homework5/time_table.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:homeworkbeer5/Models.dart';

class Countrytable extends StatefulWidget {
  const Countrytable({super.key});

  @override
  State<Countrytable> createState() => _CountryState();
}

class _CountryState extends State<Countrytable> {
              // key  ,  value    
  // late List<Map<String, dynamic>>? _data;  // declare variable is null, but be not null
  List<Country>? _countries;

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var dio = Dio(BaseOptions(responseType: ResponseType.plain));
            var response =
                await dio.get('https://api.sampleapis.com/countries/countries');
            print('Status code: ${response.statusCode}');
            response.headers.forEach((name, values) {
              print('$name: $values');
            });
            print(response.data.toString());

            // print(data.length);  // จำนวนรายการ
            // print(data[0]['name']);
            setState(() {
              var list = jsonDecode(response.data.toString());

              _countries = list.map<Country>(
                (item) => Country.fromJson(item)
              ).toList();

            });
          },
          child: Text('Test API'),
        ),
        Expanded(
          child: _countries == null
              ? SizedBox.shrink()
              : ListView.builder(
                  itemCount: _countries!.length,
                  itemBuilder: (context, index) {
                    var country = _countries![index];

                    return ListTile(
                      title: Text(country.name ?? ''),
                      subtitle: Text(country.capital ?? ''),
                      trailing: country.flag == ''
                          ? null
                          : Image.network(
                            country.flag ?? '',
                            errorBuilder: (context, error, stackTrace) {   // if error, show icon error
                                return Icon(Icons.error, color: Color.fromARGB(255, 54, 136, 244));
                              },
                          ),
                      onTap: () {
                        print('You click ${country.name}');

                         showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 500,
                                  height: 600,
                                  // color: Color.fromARGB(255, 156, 159, 159),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 181, 241, 241),
                                    border:
                                    Border.all(width: 4.0, color: Color.fromARGB(255, 58, 147, 243)), // ขอบนอก=ความหนาขอบนอก
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(country.name ?? '',
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          color: Color.fromARGB(170, 2, 80, 80)
                                        ),
                                      ),
                                      SizedBox(),
                                      Image.network(
                                        country.flag ?? '',
                                        errorBuilder:
                                          (context, error, stackTrace) {
                                        // if error, show icon error
                                            return Icon(
                                              Icons.error,
                                              color: Color.fromARGB(255, 54, 136, 244),
                                            );
                                          },
                                          fit: BoxFit.fitHeight,
                                      ),
                                      SizedBox(),
                                      Text("population No: " +  country.population.toString() ?? '',
                                         style: TextStyle(
                                          fontSize: 25.0,
                                          color: Color.fromARGB(255, 16, 108, 108)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
