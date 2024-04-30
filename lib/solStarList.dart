import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'footer.dart';

class StarList extends StatelessWidget {
  const StarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title:Text("즐겨찾기"),
      ),
        body: Container(
          width: 414,
          height: 680,
          color: Color(0xffffffff),
          child: _StarListPage(),
        ),
    );
  }
}

class _StarListPage extends StatefulWidget {
  const _StarListPage({super.key});

  @override
  State<_StarListPage> createState() => _StarListPageState();
}

class _StarListPageState extends State<_StarListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 400,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 13,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Color(0xffd6d6d6),
                            width: 1.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 310,
                          child: TextButton(
                            onPressed: (){
                              print("상세보기");
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "김소리",
                                style: TextStyle(fontSize: 23, color: Color(0xff000000)),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: () {
                              print("${index + 1}즐겨찾기 추가/삭제");
                            },
                            icon: Icon(Icons.favorite),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        Footer(),
      ],
    );
  }
}
