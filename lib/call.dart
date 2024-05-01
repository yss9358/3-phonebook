import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  void initState() {
    super.initState();
    // initState에서 호출하지 않습니다.
  }

  @override
  Widget build(BuildContext context) {
    // ModalRoute를 통해 현재 페이지에 전달된 arguments를 가져옵니다.
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    // 'phoneNumber' 키를 사용하여 값을 추출합니다.
    final String phoneNumber = args['phoneNumber']!;
    // print(phoneNumber);

    // 전화 걸기 기능을 호출합니다.
    _makePhoneCall(phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text('Call Page'),
      ),
      body: Container(),
    );
  }

  // 전화 걸기 기능을 호출하는 메서드
  Future<void> _makePhoneCall(String phoneNumber) async {
    try {
      await FlutterPhoneDirectCaller.callNumber(phoneNumber);
    } catch (error) {
      print('전화 걸기 오류: $error');
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: CallPage(),
  ));
}
