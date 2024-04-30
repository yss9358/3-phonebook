import 'package:flutter/material.dart';

class DialPage extends StatefulWidget {
  const DialPage({Key? key}) : super(key: key);

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
      phoneNumber += value;
    });
  }

  void _clearPhoneNumber() {
    setState(() {
      phoneNumber = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("키패드"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '번호를 입력하세요.',
                ),
                textAlign: TextAlign.center,
                readOnly: true,
                controller: TextEditingController(text: phoneNumber),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(10, (index) {
                  return _buildDialButton((index + 1) % 10);
                })
                  ..addAll([
                    _buildDialButton(0),
                    _buildDialButton(-1), // Clear Button
                  ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialButton(int number) {
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
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: number == -1 ? Icon(Icons.backspace) : Text('$number'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DialPage(),
  ));
}
