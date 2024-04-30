import 'package:flutter/material.dart';
//import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute를 통해 현재 페이지에 전달된 arguments를 가져옵니다.
    final args = ModalRoute.of(context)!.settings.arguments as Map;

// 'personId' 키를 사용하여 값을 추출합니다.
    final String phoneNumber = args['phoneNumber'];
    print(phoneNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //await FlutterPhoneDirectCaller.callNumber(phoneNumber);
          },
          child: Text('Call'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CallPage(),
  ));
}
