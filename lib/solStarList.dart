import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'footer.dart';
import 'PersonVo.dart';

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
  late Future<List<PersonVo>> getPersonVo;

  @override
  void initState() {
    super.initState();
    getPersonVo = getStarList();
  } //initSt

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPersonVo, //Future<> 함수명, 으로 받은 데이타
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('데이터가 없습니다.'));
        } else {
          //데이터가 있으면
          return Column(
            children: [
              Container(
                child: Text("즐겨찾는 연락처(${snapshot.data!.length})"),
              ),
              Expanded(
                child: Container(
                  height: 400,
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
                                  width: 1.0),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 310,
                                child: TextButton(
                                  onPressed: (){
                                    // print("상세보기");
                                    Navigator.pushNamed(
                                        context, "/read",
                                        arguments: {
                                          "personNo": "${snapshot.data![index].personNo}"
                                        });
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${snapshot.data![index].name}",
                                      style: TextStyle(fontSize: 23, color: Color(0xff000000)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    // print("${index + 1}즐겨찾기 추가/삭제");
                                    setState(() {
                                      snapshot.data![index].star = !snapshot.data![index].star!;
                                      starClick(snapshot.data![index].personNo!);
                                    });
                                  },
                                  icon: Icon(Icons.favorite, color: snapshot.data![index].star! ? Color(0xffff4040):Color(0xffd6d6d6),),
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
        } // 데이터가있으면
      },
    );
  }
}

//데이터연결
Future<List<PersonVo>> getStarList() async {
  try {
    var dio = Dio(); //new생략
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.get(
      // 'http://43.200.172.144:9000/phone3/list/star',
      'http://localhost:9000/phone3/list/star'
    );
    if (response.statusCode == 200) {
      //리스트생성
      List<PersonVo> personList = [];
      for (int i = 0; i < response.data["apiData"].length; i++) {
        //api데이터 저장하기
        personList.add(PersonVo.fromJson(response.data["apiData"][i]));
      }
      return personList;
    } else {
      throw Exception('api 서버 문제');
    }
  } catch (e) {
    throw Exception('Failed to load person: $e');
  }
}

void starClick(int no) async{
  try {
    var dio = Dio(); //new생략
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.post(
      // 'http://43.200.172.144:9000/phone3/list/star/${no}',
        'http://localhost:9000/phone3/list/star/${no}'
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception('api 서버 문제');
    }
  } catch (e) {
    throw Exception('Failed to load person: $e');
  }
}