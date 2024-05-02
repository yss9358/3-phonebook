import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'teamVo.dart';

class Writeform extends StatelessWidget {
  const Writeform({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text("등록폼"),
      ),
      body: Container(
        width: 414, // 고정된 가로 크기
        height: 680, // 고정된 세로 크기
        color: Color(0xffffffff),
        child: _Writeform(),
      ),
    );
  }
}

class _Writeform extends StatefulWidget {
  const _Writeform({Key? key});

  @override
  State<_Writeform> createState() => _WriteformState();
}

class _WriteformState extends State<_Writeform> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _starController = TextEditingController();

  String? _selectedGroup; // nullable로 변경
  bool isFavorite = false;

  late Future<List<TeamVo>> teamListFuture;
  late List<TeamVo> teamList;

  @override
  void initState() {
    super.initState();
    // initState 메서드에서 teamListFuture를 초기화
    teamListFuture = getTeamList();
    _selectedGroup = null; // 초기값을 null로 설정
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TeamVo>>(
      future: teamListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 아직 받아오지 못한 경우 로딩 표시
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // 데이터를 받아오는 도중 에러가 발생한 경우 에러 메시지 표시
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          // 데이터를 정상적으로 받아온 경우 폼을 표시
          // 받아온 팀 목록을 DropdownButtonFormField의 항목으로 설정
          teamList = snapshot.data!;
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
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 5, 10),
                      width: 290,
                      child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: '이름을 입력해주세요',
                              border: OutlineInputBorder())),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: _favorite(isFavorite),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(
                        Icons.call,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      width: 290,
                      child: TextFormField(
                          controller: _hpController,
                          decoration: InputDecoration(
                              hintText: '전화번호를 입력해주세요',
                              border: OutlineInputBorder())),
                    ),
                  ],
                ),
                Row(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(
                      Icons.group,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    width: 290,
                    child: DropdownButtonFormField<String>(
                      value: _selectedGroup,
                      items: teamList.map((team) {
                        return DropdownMenuItem<String>(
                          value: team.teamName ?? '',
                          child: Text(team.teamName ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGroup = value!;
                        });
                      },
                      // DropdownButtonFormField의 validator 추가
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == '그룹선택해주세요') {
                          return '그룹을 선택해주세요.';
                        }
                        return null;
                      },
                    ),
                  ),
                ]),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // 뒤로가기 동작 추가
                          Navigator.pushNamed( context, '/',);
                        },
                        child: Text(
                          "뒤로가기",
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffd6d6d6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: Size(170, 60),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          writePerson();
                          Navigator.pushNamed( context, '/',);
                        },
                        child: Text(
                          "등록",
                          style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 20,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffd6d6d6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: Size(170, 60),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // 리스트 가져오기 dio 통신
  Future<List<TeamVo>> getTeamList() async {
    try {
      var dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      final response = await dio.get(
        // 'http://localhost:9000/phone3/teamlist',
        'http://43.200.172.144:9000/phone3/teamlist',
      );

      if (response.statusCode == 200) {
        List<TeamVo> teamList = [];
        for (int i = 0; i < response.data["apiData"].length; i++) {
          TeamVo teamVo = TeamVo.fromJson(response.data["apiData"][i]);
          teamList.add(teamVo);
        }
        return teamList;
      } else {
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      throw Exception('Failed to load person: $e');
    }
  }

  // 저장하기 기능
  Future<void> writePerson() async {
    try {
      /*----요청처리-------------------*/
      // Dio 객체 생성 및 설정
      var dio = Dio();

      // 헤더 설정: json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

      // 선택된 그룹의 teamNo 값을 가져오기
      int? selectedTeamNo = getTeamNoFromName(teamList, _selectedGroup ?? '');
      bool isStarred = isFavorite;;
      // 서버 요청
      final response = await dio.post(
        // 'http://localhost:9000/phone3/insert',
        'http://43.200.172.144:9000/phone3/insert',
        data: {
          'name': _nameController.text,
          'hp': _hpController.text,
          'star': isStarred,
          'teamNo': selectedTeamNo,
        },
      );

      /*----응답처리-------------------*/
      if (response.statusCode == 200) {
        // 접속 성공 200 이면
        //print(response.data); // json->map 자동 변환
        // return PersonVo.fromJson(response.data["apiData"]);
      } else {
        // 접속 실패 404, 502 등등 api 서버 문제
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      // 예외 발생
      throw Exception('Failed to load person: $e');
    }
  }

  // 선택된 그룹의 teamNo 값을 가져오기
  int? getTeamNoFromName(List<TeamVo> teamList, String groupName) {
    for (var team in teamList) {
      if (team.teamName == groupName) {
        return team.teamNo;
      }
    }
    return null;
  }

  Color _favorite(bool isFavorite) {
    if (isFavorite == true) {
      return Color(0xffff4040);
    } else {
      return Color(0xffd6d6d6);
    }
  }
}
