import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'footer.dart';
import 'PersonVo.dart';

late Future<List<PersonVo>> getPersonVo;
bool isFind = false;
TextEditingController _fineController = TextEditingController();


class MainList extends StatefulWidget {
  const MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}
class _MainListState extends State<MainList> {

  @override
  void initState() {
    super.initState();
  }
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center, //세로정렬
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 340,
                  height: 50,
                  child: TextFormField(
                    controller: _fineController,
                    onChanged: (text) {
                      setState(() {
                        isFind = true;
                        if (text.isNotEmpty) {
                          getPersonVo = getfindList(text);
                        } else {
                          getPersonVo = getMainList();
                        }
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '검색',
                      label: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/write");
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: _MainListPage(),
              ),
            )
          ],
        ),
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


  //초기화
  @override
  void initState() {
    super.initState();
    if(!isFind){
      // print("isNotFind");
      getPersonVo = getMainList();
    }
  } //initState


  //화면
  @override
  Widget build(BuildContext context) {
    // print(isFind);
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
                child: Text("저장된 연락처(${snapshot.data!.length})"),
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
                                  width: 1.0), // 밑에만 border 추가
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 310,
                                child: TextButton(
                                  onPressed: () {
                                    // print("${snapshot.data![index].name}");
                                    Navigator.pushNamed(context, "/read",
                                        arguments: {
                                          "personNo": snapshot.data![index].personNo
                                        });
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${snapshot.data![index].name}",
                                      style: TextStyle(
                                          fontSize: 23,
                                          color: Color(0xff000000)),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    // print("${snapshot.data![index].hp}전화걸기");
                                    Navigator.pushNamed(context, "/call",
                                        arguments: {
                                          "hp": "${snapshot.data![index].hp}"
                                        });
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
        } // 데이터가있으면
      },
    );
  }

}
  Future<List<PersonVo>> getMainList() async {
    try {
      var dio = Dio(); //new생략
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
          // 'http://43.200.172.144:9000/phone3/list/main',
          'http://localhost:9000/phone3/list/main');
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

//검색
Future<List<PersonVo>> getfindList(String keyword) async {
  // print(keyword);
  try {
    var dio = Dio(); //new생략
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.post(
      // 'http://43.200.172.144:9000/phone3/list/main',
      'http://localhost:9000/phone3/list/find',
      // data: _fineController.text,
      data: keyword,
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
