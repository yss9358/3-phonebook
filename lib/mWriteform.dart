import 'package:flutter/material.dart';

class Writeform extends StatelessWidget {
  const Writeform({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title:Text("등록폼"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _Writeform(),
      ),
    );
  }
}

class _Writeform extends StatefulWidget {
  const _Writeform({super.key});

  @override
  State<_Writeform> createState() => _WriteformState();
}

class _WriteformState extends State<_Writeform> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Icon(
              Icons.account_circle,
              size: 160,
              color: Color(0xff737373),
            ),
            Row(
              children: [
                Text("이름"),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 10, 0, 10),
                  width: 300,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '이름을 입력해 주세요',
                          border: OutlineInputBorder()
                      )
                  ),
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.favorite)),
              ],
            ),
            Row(
              children: [
                Text("전화번호"),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
                  width: 300,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '전화번호를 입력해 주세요',
                          border: OutlineInputBorder()
                      )
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("전화번호"),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 10),
                  width: 300,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '전화번호를 입력해 주세요',
                          border: OutlineInputBorder()
                      )
                  ),
                ),
              ],
            ),
            Row(
                children: [
                  Container(
                      width: 150,
                      margin: EdgeInsets.fromLTRB(25, 150, 0, 0),
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text("뒤로가기"))),
                  Container(
                      width: 150,
                      margin: EdgeInsets.fromLTRB(25, 150, 25, 0),
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text("등록"))),
                ]
            )

          ]
      ),
    );
  }
}