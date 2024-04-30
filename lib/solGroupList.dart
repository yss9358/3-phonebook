import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'footer.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title:Text("그룹리스트"),
      ),
      body: Container(
        width: 414,
        height: 680,
        color: Color(0xffffffff),
        child: _GroupListPage(),
      ),
    );
  }
}

class _GroupListPage extends StatefulWidget {
  const _GroupListPage({super.key});

  @override
  State<_GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<_GroupListPage> {

  @override
  void initState() {
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 400,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Color(0xffd6d6d6),
                            width: 1.0), // 밑에만 border 추가
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 320,
                          child: TextButton(
                            onPressed: (){
                              print("그룹리스트");
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "그룹명",
                                style: TextStyle(fontSize: 23, color: Color(0xff000000)),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "(0)",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffd6d6d6)
                            ),
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
