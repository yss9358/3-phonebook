import 'package:flutter/material.dart';
import 'footer.dart';
import 'PersonVo.dart';
import 'package:dio/dio.dart';

class DialPage extends StatefulWidget {
  const DialPage({Key? key});

  @override
  _DialPageState createState() => _DialPageState();
}

class _DialPageState extends State<DialPage> {
  String phoneNumber = '';
  late Future<List<PersonVo>> personVoFuture;

  @override
  void initState() {
    super.initState();
    personVoFuture = Future.value([]);
  }

  void _updatePhoneNumber(String newNumber) {
    setState(() {
      phoneNumber = newNumber;
    });
  }

  void _addToPhoneNumber(String value) {
    setState(() {
      if (phoneNumber.length == 3 || phoneNumber.length == 8) {
        phoneNumber += '-';
      }
      phoneNumber += value;
      personVoFuture = getPersonInfo(phoneNumber);
    });
  }

  void _clearPhoneNumber() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
        if (phoneNumber.isNotEmpty) {
          personVoFuture = getPersonInfo(phoneNumber);
        } else {
          personVoFuture = Future.value([]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text("키패드"),
      ),
      body: Container(
        width: 414,
        height: 680,
        color: Color(0xffffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: _updatePhoneNumber,
                      readOnly: true,
                      style: TextStyle(fontSize: 28),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: phoneNumber,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: FutureBuilder<List<PersonVo>>(
                        future: personVoFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (var person in snapshot.data!)
                                  GestureDetector(
                                    onTap: () {
                                      _updatePhoneNumber(person.hp!);
                                      personVoFuture =
                                          getPersonInfo(person.hp!);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${person.name}  ${person.hp}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 6, 2),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDialButton(1),
                          _buildDialButton(2),
                          _buildDialButton(3),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDialButton(4),
                          _buildDialButton(5),
                          _buildDialButton(6),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDialButton(7),
                          _buildDialButton(8),
                          _buildDialButton(9),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDialButton('*'),
                          _buildDialButton(0),
                          _buildDialButton('#'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: 80),
                          InkWell(
                            onTap: () {
                              print("전화 걸기");
                              Navigator.pushNamed(context, '/call',
                                  arguments: {"phoneNumber": this.phoneNumber});
                            },
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Icon(Icons.call, color: Colors.white),
                            ),
                          ),
                          InkWell(
                            onTap: _clearPhoneNumber,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Icon(Icons.backspace, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildDialButton(dynamic number) {
    return InkWell(
      onTap: () {
        if (number == -1) {
          _clearPhoneNumber();
        } else {
          _addToPhoneNumber(number.toString());
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: number == -1 ? Colors.red : Color(0xffd6d6d6),
          shape: BoxShape.circle,
        ),
        child: number == -1
            ? Icon(Icons.backspace)
            : Text('$number', style: TextStyle(fontSize: 24)),
      ),
    );
  }

  Future<List<PersonVo>> getPersonInfo(String phoneNumber) async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        'http://localhost:9000/phone3/search/$phoneNumber',
      );

      if (response.statusCode == 200) {
        if (response.data["apiData"] != null &&
            response.data["apiData"].isNotEmpty) {
          List<PersonVo> personList = [];
          for (int i = 0; i < response.data["apiData"].length; i++) {
            PersonVo personVo =
            PersonVo.fromJson(response.data["apiData"][i]);
            personList.add(personVo);
          }
          return personList;
        } else {
          return [];
        }
      } else {
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: DialPage(),
  ));
}
