import 'package:flutter/material.dart';
import 'footer.dart';
import 'package:dio/dio.dart';
import 'teamVo.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title:Text("그룹리스트"),

      ),
      body: SingleChildScrollView(
        child: Container(
          width: 414,
          height: 630,
          color: Color(0xffffffff),
          child: _GroupListPage(),
        ),
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

  late Future<List<TeamVo>> list ;
  bool isTrue = false;

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    list = getList();
    return FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('데이터가 없습니다.'));
          } else{
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        margin: EdgeInsets.fromLTRB(310, 0, 0, 0),
                        decoration: BoxDecoration(
                          // border: Border.all(width: 1)
                        ),
                        child: IconButton(
                          onPressed: (){
                            _groupNameController.text = '';
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    backgroundColor: Color(0xffffffff),
                                    title: Container(
                                        alignment: Alignment.center,
                                        child: Text('그룹 추가',
                                          style: TextStyle(fontSize: 20),)
                                    ),
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            child: TextFormField(
                                              style: TextStyle(fontSize: 20),
                                              maxLength: 10,
                                              controller: _groupNameController,
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                // enabledBorder: OutlineInputBorder(),
                                                hintText: '그룹명 입력하기',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 40,
                                            child: TextButton(
                                                onPressed: () {
                                                  insertTeam();
                                                  setState(() {

                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text('추가')),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 40,
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('뒤로가기')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                             );
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),

                      Container(
                        height: 505,
                        child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
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
                                      width: 190,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context,
                                              '/groupin',
                                              arguments: {
                                                'teamNo' : snapshot.data![index].teamNo
                                              }
                                          );
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${snapshot.data![index].teamName}",
                                            style: TextStyle(
                                                fontSize: 23, color: Color(0xff000000)),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      width: 30,
                                      child: Text(
                                        "(${snapshot.data![index].count})",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xffd6d6d6)
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: TextButton(
                                        onPressed: (){
                                          _groupNameController.text = '${snapshot.data![index].teamName}';
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Center(
                                                  child: AlertDialog(
                                                    backgroundColor: Color(0xffffffff),
                                                    title: Container(
                                                      alignment: Alignment.center,
                                                      height: 25,
                                                      child: Text('그룹 수정',style: TextStyle(fontSize: 21),),
                                                    ),
                                                    content: Container(
                                                      height: 100,
                                                      width: 30,
                                                      alignment: Alignment.center,
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            style: TextStyle(fontSize: 18),
                                                            maxLength: 10,
                                                            controller: _groupNameController,
                                                            textAlign: TextAlign.center,
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      Container(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              width: 100,
                                                              height: 50,
                                                              child: TextButton(onPressed: (){
                                                                updateTeam(snapshot.data![index].teamNo!);
                                                                setState(() {
                                                                  // print('수정 성공');
                                                                });
                                                                Navigator.pop(context);
                                                              },
                                                                  child: Text('수정')),
                                                            ),
                                                            Container(
                                                              width: 100,
                                                              height: 50,
                                                              child: TextButton(onPressed: (){
                                                                Navigator.pop(context);
                                                              },
                                                                  child: Text('뒤로가기')),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }
                                          );
                                        },
                                        child: Text('[수정]')
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
                                                              deleteTeam(snapshot.data![index].teamNo!);
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
                                    ),
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
    );
  }

  // 수정
  Future<void> updateTeam(int no) async {
    try{
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.put(
        'http://43.200.172.144:9000/phone3/teams',
        // 'http://localhost:9000/phone3/teams',
        data: {
          'teamName' : _groupNameController.text,
          'teamNo' : no
        }
      );

      if(response.statusCode == 200){
        if(response.data.apiData == 1){

        } else {
          throw Exception('api 서버 문제');
        }

      } else {
        throw Exception('api 서버 문제');
      }
    } catch(e){
      throw Exception('Failed to load person: $e');
    }
  }

  // 삭제
  Future<void> deleteTeam(int no) async{
    try{
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.delete(
        'http://43.200.172.144:9000/phone3/teams/${no}',
        // 'http://localhost:9000/phone3/teams/${no}',
      );
      if(response.statusCode == 200){
        if(response.data['apiData'] == 1){
          setState(() {
            // print('삭제성공');
          });

        } else {
          throw Exception('api 서버 문제');
        }
      } else {
        throw Exception('api 서버 문제');
      }
    }catch(e){
      throw Exception('Failed to load person: $e');
    }
  }


  // 추가
  Future<void> insertTeam() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.post (
        'http://43.200.172.144:9000/phone3/teams',
        // 'http://localhost:9000/phone3/teams',
        data:{
          'teamName' : _groupNameController.text
        }
      );
      if(response.statusCode == 200){

      } else {
        throw Exception('api 서버 문제');
      }
    } catch(e){
      throw Exception('Failed to load person: $e');
    }
  }

  // 전체 리스트 불러오기
  Future<List<TeamVo>> getList() async{
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        'http://43.200.172.144:9000/phone3/teams',
        // 'http://localhost:9000/phone3/teams'
      );

      if (response.statusCode == 200) {
        // print(response.data['apiData']);
        List<TeamVo> list = [];
        for(int i=0; i<response.data['apiData'].length; i++){
          TeamVo vo = TeamVo.fromJson(response.data['apiData'][i]);
          list.add(vo);
        }
        // print(list);
        return list;
      } else {
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }
}

