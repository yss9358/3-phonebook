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
        width: 414,
        height: 680,
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
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Icon(
                    Icons.person,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 5, 10),
                  width: 290,
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
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Icon(
                    Icons.call,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  width: 290,
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
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Icon(
                    Icons.group,),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                  width: 290,
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: '그룹을 선택해주세요',
                          border: OutlineInputBorder()
                      )
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Row(
                children: [
                  ButtonTheme(
                    child: ElevatedButton(
                        onPressed: () {
                      // 뒤로가기 동작 추가
                      Navigator.pop(context);
                      },
                    child: Text(
                        "뒤로가기",
                    style: TextStyle(
                    color: Color(0xff737373),
                    fontSize: 20), // 버튼 텍스트 색상 및 크기
                    ),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),),
                    minimumSize: Size(200, 60),
                    ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                      // 삭제 동작 추가
                      showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                      backgroundColor: Color(0xff737373), // 배경 색상 설정
                      title: Text("삭제"),
                      content: Text("정말로 삭제하시겠습니까?"),
                      actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      child: Text(
                          "취소",
                          style: TextStyle(
                          color: Color(0xff000000)), // 버튼 텍스트 색상
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                      // 삭제 동작 수행
                      Navigator.pop(context);
                        },
                      child: Text(
                          "삭제",
                          style: TextStyle(
                          color: Color(0xff000000)), // 버튼 텍스트 색상
                        ),
                      ),
                      ],
                      ),
                      );
                      },
                      child: Text(
                          "삭제",
                      style: TextStyle(
                      color: Color(0xff737373),
                      fontSize: 20), // 버튼 텍스트 색상 및 크기
                      ),
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),),
                      minimumSize: Size(200, 60),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ]
      ),
    );
  }
}