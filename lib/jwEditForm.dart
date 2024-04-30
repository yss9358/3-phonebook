import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  const EditForm({super.key});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          title: Text("수정")),
      body: Container(
        // padding: EdgeInsets.all(15),
        //color: Color(0xffd6d6d6),
        //child: _EditForm()
      ),
    );
  }
}



