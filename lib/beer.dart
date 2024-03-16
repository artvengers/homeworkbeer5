import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:homeworkbeer5/Models.dart';




class Beers extends StatefulWidget {
  const Beers({super.key});

  @override
  State<Beers> createState() => _NotificationState();
}

class _NotificationState extends State<Beers> {
  // key  ,  value
  // late List<Map<String, dynamic>>? _data;  // declare variable is null, but be not null
  List<BeerM>? _beer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var dio = Dio(BaseOptions(responseType: ResponseType.plain));
            var response =
                await dio.get('https://api.sampleapis.com/beers/ale');
            print('Status code: ${response.statusCode}');
            response.headers.forEach((title, values) {
            });
            print(response.data.toString());
            setState(() {
              var list = jsonDecode(response.data.toString());

              _beer = list.map<BeerM>((item) => BeerM.fromJson(item)).toList();
            });
          },
          child: Text('Beers'),
        ),
        Expanded(
          child: _beer == null
              ? SizedBox.shrink()
              // : calldt(),
              : ListView.builder(
                  itemCount: _beer!.length,
                  itemBuilder: (context, index) {
                    var beer = _beer![index];

                    return ListTile(
                      title: Text(beer.name ?? ''),
                      subtitle: Text(beer.price ?? ''),
                      trailing: beer.image == ''
                          ? null
                          : Image.network(
                              beer.image ?? '',
                              errorBuilder: (context, error, stackTrace) {
                                // if error, show icon error
                                return Icon(Icons.error,
                                    color: Color.fromARGB(255, 54, 136, 244));
                              },
                            ),
                      onTap: () {
                        print('You click ${beer.name}');
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
                                      Text(beer.name ?? '',
                                        style: TextStyle(
                                          fontSize: 35.0,
                                          color: Color.fromARGB(170, 2, 80, 80)
                                        ),
                                      ),
                                      SizedBox(),
                                      Image.network(
                                        beer.image ?? '',
                                        errorBuilder:
                                          (context, error, stackTrace) {
                                        // if error, show icon error
                                            return Icon(
                                              Icons.error,
                                              color: Color.fromARGB(255, 54, 136, 244),
                                            );
                                          },
                                          fit: BoxFit.contain,
                                      ),
                                      SizedBox(),
                                      Text("Price: " +  beer.price.toString() ?? '',
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
