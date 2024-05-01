import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'personVo.dart';
import 'dart:async';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  //기본레이아웃
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff), // 앱 바 배경색
        title: Text("연락처 정보"), // 앱 바 제목
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: ButtonTheme(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/editform',
                  );
                },
                child: Text(
                  "편집",
                  style: TextStyle(
                      color: Color(0xff737373), fontSize: 15), // 버튼 텍스트 스타일
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  minimumSize: Size(100, 50), // 버튼 최소 크기
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: 414,
        height: 680,
        padding: EdgeInsets.all(10),
        color: Color(0xffffffff),
        child: _ReadPage(),
      ),
    );
  }
}

//상태변화를 감시하게 등록시키는 클래스
class _ReadPage extends StatefulWidget {
  const _ReadPage({super.key});

  @override
  State<_ReadPage> createState() => _ReadPageState();
}

//할일 정의 클래스(통신, 데이터적용)
class _ReadPageState extends State<_ReadPage> {
  //미래의 정우성 데이터가 담길거야
  late Future<PersonVo> personVoFuture;

  bool isFavorite = false;

  //초기화함수 (1번만 실행됨)
  @override
  void initState() {
    super.initState();

    bool isFavorite = false;
  }

//화면그리기
  @override
  Widget build(BuildContext context) {
    // ModalRoute를 통해 현재 페이지에 전달된 arguments를 가져옵니다.
    late final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args == null) {
      return Center(child: Text('전달된 인수가 없습니다.'));
    }

    //late final args = ModalRoute.of(context)!.settings.arguments as Map;
    // 'personNo' 키를 사용하여 값을 추출합니다.
    late final personNo = args['personNo'].toString();

    //personNo의 데이터를 서버로 부터 가져오기
    personVoFuture = getPersonByNo(personNo);

    print("build(): 그리기 작업");
    print(personNo);
    print("데이터 가져오는 중");
    return FutureBuilder(
      future: personVoFuture,
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
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10), // 상단 여백 추가
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(
                      Icons.account_circle,
                      size: 160, // 아이콘 크기
                      color: Color(0xff737373), // 아이콘 색상
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Center(
                child: Text(
                  "${snapshot.data!.name}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, "/call",
                          arguments: {
                            "hp": "${snapshot.data!.hp}"
                          });
                    },
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xff737373), // 아이콘 색상
                    ),
                    label: Text(
                      "전화",
                      style: TextStyle(
                          color: Color(0xff737373), fontSize: 15), // 버튼 텍스트 스타일
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(130, 50), // 버튼 최소 크기
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.message,
                      color: Color(0xff737373), // 아이콘 색상
                    ),
                    label: Text(
                      "메시지",
                      style: TextStyle(
                          color: Color(0xff737373), fontSize: 15), // 버튼 텍스트 스타일
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(130, 50), // 버튼 최소 크기
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      star(int.parse(personNo));
                      isFavorite = !isFavorite;
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: _favorite(isFavorite), // 아이콘 색상
                    ),
                    label: Text(
                      "즐겨찾기",
                      style: TextStyle(
                          color: Color(0xff737373), fontSize: 15), // 버튼 텍스트 스타일
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minimumSize: Size(130, 50), // 버튼 최소 크기
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: 414,
                height: 100,
                child:
                    _buildInfoBox("전화번호", "${snapshot.data!.hp}"), // 전화번호 정보 박스
              ),
              SizedBox(height: 20),
              Container(
                width: 414,
                height: 100,
                child:
                    _buildInfoBox("그룹", "${snapshot.data!.teamName}"), // 그룹 정보 박스
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "뒤로가기",
                        style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 20), // 버튼 텍스트 스타일
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(200, 60), // 버튼 최소 크기
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("삭제"),
                            content: Text("정말로 삭제하시겠습니까?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  print("11111111");
                                },
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      color: Color(0xff000000)), // 버튼 텍스트 스타일
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 삭제 동작 추가
                                  Navigator.pop(context);

                                  //삭제 api 호출

                                  //화면 뒤로가기
                                  deleteItem(personNo);
                                  Navigator.pushNamed(context, "/");

                                  print("22222222222");
                                },
                                child: Text(
                                  "삭제",
                                  style: TextStyle(
                                      color: Color(0xff000000)), // 버튼 텍스트 스타일
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
                            fontSize: 20), // 버튼 텍스트 스타일
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(200, 60), // 버튼 최소 크기
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildInfoBox(String title, String content) {
    return Container(
      padding: EdgeInsets.all(10), // 박스 내부 여백
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // 테두리 선 색상
        borderRadius: BorderRadius.circular(10), // 테두리 둥근 모서리
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // 제목 스타일
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(fontSize: 20), // 내용 스타일
          ),
        ],
      ),
    );
  }
}

//3번(정우성) 데이타 가져오기
Future<PersonVo> getPersonByNo(String personNo) async {
  print(personNo);
  print("데이터 가져오는중 ");

  try {
    /*----요청처리-------------------*/
    // Dio 객체 생성
    var dio = Dio();

    // 헤더 설정: JSON으로 데이터 전송
    dio.options.headers['Content-Type'] = 'application/json';

    // 서버 요청
    final response = await dio.get(
      'http://localhost:9000/phone3/phones/${personNo}',
    );

    /*----응답처리-------------------*/
    if (response.statusCode == 200) {
      print(response.data); // json->map 자동변경
      return PersonVo.fromJson(response.data["apiData"]);
    } else {
      //접속실패 404, 502등등 api서버 문제
      throw Exception('api 서버 문제');
    }
  } catch (e) {
    //예외 발생
    throw Exception('Failed to load person: $e');
  }

} //getPersonByNo
Future<void> star(int personNo) async {
  try {
    var dio = Dio(); //new생략

    dio.options.headers['Content-Type'] = 'application/json';

    final response = await dio.put(
      'http://localhost:9000/phone3/star',
      data: {
        'personNo': personNo
      },
    );
    if (response.statusCode == 200) {} else {
      throw Exception('api 서버 문제');
    }
  } catch (e) {
    throw Exception('Failed to load person: $e');
  }
}

Future<PersonVo> deleteItem(String personNo) async {
  print(personNo);
  print("삭제API 실행 ");

  try {
    /*----요청처리-------------------*/
    // Dio 객체 생성
    var dio = Dio();

    // 헤더 설정: JSON으로 데이터 전송
    dio.options.headers['Content-Type'] = 'application/json';

    // 서버 요청
    final response = await dio.get(
      'http://localhost:9000/phone3/delete/${personNo}',
    );

    /*----응답처리-------------------*/
    if (response.statusCode == 200) {
      print(response.data); // json->map 자동변경
      return PersonVo.fromJson(response.data["apiData"]);
    } else {
      //접속실패 404, 502등등 api서버 문제
      throw Exception('api 서버 문제');
    }
  } catch (e) {
    //예외 발생
    throw Exception('Failed to load person: $e');
  }

}
Color _favorite(bool isFavorite) {
  if (isFavorite == true) {
    return Color(0xffff4040);
  } else {
    return Color(0xff969696);
  }
}
