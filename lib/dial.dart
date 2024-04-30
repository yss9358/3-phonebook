import 'package:flutter/material.dart';
import 'footer.dart';

class DialPage extends StatefulWidget {
  const DialPage({super.key});

  @override
  _DialPageState createState() => _DialPageState();
}

class _DialPageState extends State<DialPage> {
  String phoneNumber = '';

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
    });
  }

  void _clearPhoneNumber() {
    setState(() {
      if (phoneNumber.isNotEmpty) {
        phoneNumber = phoneNumber.substring(0, phoneNumber.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("키패드"),
      ),
      body: Container(
        width: 414,
        height: 680,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: TextField(
                  textAlign: TextAlign.center,
                  readOnly: true,
                  style: TextStyle(fontSize: 28), // Increased font size
                  decoration: InputDecoration(
                    border: InputBorder.none, // Removed underline
                    hintText: phoneNumber, // Displayed entered number as hint
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                          _buildDialButton('0'), // Placeholder for space
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
                            onTap: (){
                              print("전화 걸기");
                              Navigator.pushNamed( context,  '/call',
                                  arguments: {
                                    "phoneNumber": this.phoneNumber
                                  }
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 80,
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
                              width: 80,
                              height: 80,
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
          // Clear Button
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
        child: number == -1 ? Icon(Icons.backspace) : Text('$number', style: TextStyle(fontSize: 24)), // Increased font size
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DialPage(),
  ));
}
