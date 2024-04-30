import 'package:flutter/material.dart';
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

  final TextEditingController _groupNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }






  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(310, 0, 0, 0),
                decoration: BoxDecoration(
                  // border: Border.all(width: 1)
                ),
                child: IconButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return Center(
                            child: AlertDialog(
                              backgroundColor: Color(0xffffffff),
                              title: Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // border: Border.all(width: 1)
                                  ),
                                  child: Text('그룹 추가',style: TextStyle(fontSize: 23),)),
                              content: TextFormField(

                                style: TextStyle(fontSize: 23),
                                maxLength: 10,
                                controller: _groupNameController,
                                // textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: '그룹명을 입력하세요.',

                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          child: Text('추가')),
                                    ),
                                    Container(
                                      width: 100,
                                      child: TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          child: Text('뒤로가기')),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          );
                        }
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ),

              Container(
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
                              width: 270,
                              child: TextButton(
                                onPressed: () {
                                  print("그룹리스트");
                                  Navigator.pushNamed(
                                    context,
                                    '/groupin',
                                    arguments: {
                                      'teamNo' : 1
                                    }
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "그룹명",
                                    style: TextStyle(
                                        fontSize: 23, color: Color(0xff000000)),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "(0)",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffd6d6d6)
                                ),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed:(){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return Center(
                                          child: AlertDialog(
                                            backgroundColor: Color(0xffffffff),
                                            title: Container(
                                                alignment: Alignment.center,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  // border: Border.all(width: 1)
                                                ),
                                                child: Text(
                                                  '그룹 삭제',
                                                  style: TextStyle(fontSize: 23),
                                                )
                                            ),
                                            content: Container(
                                              height: 50,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '삭제하시겠습니까?',
                                                style: TextStyle(fontSize: 23),
                                                // textAlign: TextAlign.center,
                                              ),
                                            ),
                                            actions: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 100,
                                                    child: TextButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                        child: Text('삭제')),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    child: TextButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                        child: Text('뒤로가기')),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: Text('[삭제]',style: TextStyle(fontSize: 15,color: Color(0xff000000)),),),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
        Footer(),
      ],
    );
  }
}