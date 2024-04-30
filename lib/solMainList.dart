import 'package:flutter/material.dart';
import 'footer.dart';

class MainList extends StatelessWidget {
  const MainList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text("연락처"),
      ),
      body: Container(
        width: 414,
        height: 680,
        color: Color(0xffffffff),
        child: _MainListPage(),

      ),
    );
  }
}

class _MainListPage extends StatefulWidget {
  const _MainListPage({super.key});

  @override
  State<_MainListPage> createState() => _MainListPageState();
}

class _MainListPageState extends State<_MainListPage> {
  //화면
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center, //세로정렬
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: 340,
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '검색',
                  label: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              // margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
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
                            width: 1.0), // 밑에만 border 추가
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 310,
                          child: Text(
                            "김소리",
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            onPressed: (){
                              print("${index+1}전화걸기");
                            },
                            icon: Icon(Icons.call),
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
