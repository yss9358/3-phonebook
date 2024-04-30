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
        width: 414, // 고정된 가로 크기
        height: 680, // 고정된 세로 크기
        color: Color(0xffffffff),
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
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Icon(
                    Icons.person,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 5, 10),
                  width: 290,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '이름을 입력해주세요',
                          border: OutlineInputBorder()
                      )
                  ),
                ),
                IconButton(
                    onPressed: (){
                    },
                    icon: Icon(Icons.favorite),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Icon(
                    Icons.call,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  width: 290,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '전화번호를 입력해주세요',
                          border: OutlineInputBorder()
                      )
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Icon(
                    Icons.group,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  width: 290,
                  child: TextFormField(
                      decoration:InputDecoration(
                              hintText: '전화번호를 입력해주세요',
                              border: OutlineInputBorder()
                          )
                      ),
                  ),
                  ]
                ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 뒤로가기 동작 추가
                      Navigator.pop(context);
                    },
                    child: Text(
                      "뒤로가기",
                      style: TextStyle(
                        color: Color(0xff737373),
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(170, 60),
                    ),
                  ),

                  SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: () {
                      // 저장 동작 추가
                      // 사용자가 입력한 값을 nameController.text, hpController.text, groupController.text를 통해 얻을 수 있어요.
                      // 여기서는 간단하게 컨텍스트를 팝합니다.
                      Navigator.pop(context);
                    },
                    child: Text(
                      "저장",
                      style: TextStyle(
                        color: Color(0xff737373),
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(170, 60),
                    ),
                  ),
                ],
              ),
            ),
          ],

      ),

    );
  }
}