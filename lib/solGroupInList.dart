import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'PersonVo.dart';
import 'footer.dart';

class GroupInList extends StatelessWidget {
  const GroupInList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text("그룹"),
      ),
      body: Container(
        width: 414,
        height: 680,
        color: Color(0xffffffff),
        child: _GroupInPage(),
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

  late Future<List<PersonVo>> getPersonVo;

  //초기화
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    late final args = ModalRoute.of(context)!.settings.arguments as Map;
    late final no = args["teamNo"];
    // print("그룹별 리스트: ${no}");
    getPersonVo = getGroupList(no);
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
          if (snapshot.data!.length == 0) {
            return Center(child: Text('등록되어있는 연락처가 없습니다.'));
          } else {
            return Column(
              children: [
                Container(
                  child: Text("${snapshot.data![0].teamName}(${snapshot.data!.length})"),
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
                                    onPressed: () {
                                      print(
                                          "상세보기:${snapshot.data![index].name}");
                                      Navigator.pushNamed(
                                          context, "/read",
                                          arguments: {
                                            "personNo": "${snapshot.data![index]
                                                .personNo}"
                                          });
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${snapshot.data![index].name}",
                                        style: TextStyle(fontSize: 23,
                                            color: Color(0xff000000)),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        print("${snapshot.data![index]
                                            .personNo!}즐겨찾기 추가/삭제");
                                        snapshot.data![index].star =
                                        !snapshot.data![index].star!;
                                        starClick(
                                            snapshot.data![index].personNo!); //
                                      });
                                    },
                                    icon: Icon(Icons.favorite,
                                      color: snapshot.data![index].star!
                                          ? Color(0xffff4040)
                                          : Color(0xffd6d6d6),),
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
        };
      }
    );
  }
}

//데이터연결
Future<List<PersonVo>> getGroupList(int no) async {
  try {
    var dio = Dio(); //new생략
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.get(
      'http://43.200.172.144:9000/phone3/list/group/${no}',
      // 'http://localhost:9000/phone3/list/group/${no}'
    );
    if (response.statusCode == 200) {
      // print(response.data);
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
  // print(no);
  try {
    var dio = Dio(); //new생략
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.post(
      'http://43.200.172.144:9000/phone3/list/star/${no}',
      // 'http://localhost:9000/phone3/list/star/${no}'
    );
    if (response.statusCode == 200) {
      // print(response.data);

    } else {
      throw Exception('api 서버 문제');
    }
  } catch (e) {
    throw Exception('Failed to load person: $e');
  }
}