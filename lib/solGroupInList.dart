import 'package:flutter/material.dart';

class GroupInList extends StatelessWidget {
  const GroupInList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("00그룹")),
      body: Container(
        child: Container(),
      ),
    );
  }
}

class _GroupInPage extends StatefulWidget {
  const _GroupInPage({super.key});

  @override
  State<_GroupInPage> createState() => _GroupInPageState();
}

class _GroupInPageState extends State<_GroupInPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
