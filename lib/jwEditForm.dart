import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'teamVo.dart';
import 'personVo.dart';

class EditForm extends StatelessWidget {
  const EditForm({Key? key}) : super(key: key);

  //레이아웃 클래스
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text('회원정보 수정'),
      ),
      body: Container(
        width: 414, // 고정된 가로 크기
        height: 680, // 고정된 세로 크기
        color: Color(0xffffffff),
        child: _EditForm(),
      ),
    );
  }
}

//등록
class _EditForm extends StatefulWidget {
  const _EditForm({Key? key});

  @override
  State<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  //선택한 사용자 번호
  late int personNo; // 사용자 번호를 저장할 변수

  /*input박스의 변화를 체크하는 변수 생성*/
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hpController = TextEditingController();

  String? _selectedGroup;
  late Future<List<TeamVo>> teamListFuture;
  late List<TeamVo> teamList;
  late Future<PersonVo> personVoFuture;

  @override
  void initState() {
    super.initState();
    _selectedGroup = null; // 초기값을 null로 설정
    teamListFuture = getTeamList();
  }

  //화면에 그리기
  @override
  Widget build(BuildContext context) {
    // ModalRoute를 통해 현재 페이지에 전달된 arguments를 가져옵니다.
    late final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    if (args == null) {
      // 예외 처리 또는 오류 메시지 표시
      return Container(child: Text('전달된 인수가 없습니다.'));
    }
    // 'personNo' 키를 사용하여 값을 추출합니다.
    final int personNo = args['personNo'];
    personVoFuture = getPersonByNo(personNo);

    print(personVoFuture.toString());

    return FutureBuilder<List<TeamVo>>(
      future: teamListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('데이터를 불러오는 데 실패했습니다.'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('데이터가 없습니다.'));
        } else {
          //데이터가 있으면
          teamList = snapshot.data!;

          // 초기값 설정
          // if (_selectedGroup == null) {
          //   _selectedGroup = teamList.isNotEmpty ? teamList[0].teamName : null;
          // }

          return Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Icon(
                      Icons.account_circle,
                      size: 160,
                      color: Color(0xff737373),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xff737373),
                        ),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          width: 300,
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 50,
                          color: Color(0xff737373),
                        ),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          width: 300,
                          child: TextFormField(
                            controller: _hpController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: 50,
                          color: Color(0xff737373),
                        ),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                          width: 300,
                          child: DropdownButtonFormField<String>(
                            value: _selectedGroup,
                            items: teamList.map((team) {
                              return DropdownMenuItem<String>(
                                value: team.teamName ?? '',
                                child: Text(team.teamName ?? ''),
                              );
                            }).toList(),
                            onChanged: (value) {

                                _selectedGroup = value!;

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
                      ],
                    ),
                    SizedBox(height: 150),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // 뒤로가기 동작 추가
                              Navigator.pop(context);
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
                              print("데이터 전송");
                              updatePerson(personNo);
                              Navigator.pushNamed(
                                context,
                                '/',
                              );
                            },
                            child: Text(
                              "수정",
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
              ),
            ),
          );
        }
      },
    );
  }

  //3번(정우성) 데이타 가져오기
  Future<PersonVo> getPersonByNo(int personNo) async {
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
        print(response.data["apiData"]);
        PersonVo vo = PersonVo.fromJson(response.data["apiData"]);
        print(vo.name);

        _nameController.text = vo.name!;
        _hpController.text = vo.hp!;
        _selectedGroup = vo.teamName!;

        // print(response.data); // json->map 자동변경
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

  //수정하기, 입력폼의 내용을 서버에 전송하여 수정합니다.
  Future<void> updatePerson(int personNo) async {
    try {
      /*----요청처리-------------------*/
      //Dio 객체 생성 및 설정
      var dio = Dio();

      // 헤더설정:json으로 전송
      dio.options.headers['Content-Type'] = 'application/json';

      // 서버 요청 전에 디버깅 로그 추가
      print('수정할 사용자 번호: ${personNo}');
      print('수정할 사용자 이름: ${_nameController.text}');
      print('수정할 사용자 전화번호: ${_hpController.text}');
      print('수정할 사용자 팀 이름: ${_selectedGroup}');
      

      int? selectedTeamNo = getTeamNoFromName(teamList, _selectedGroup ?? '');

      print(selectedTeamNo);

      // 서버 요청
      final response = await dio.put(
        'http://localhost:9000/phone3/phones/modify/${personNo}',
        data: {
          'personNo': personNo,
          'name': _nameController.text,
          'hp': _hpController.text,
          'teamNo': selectedTeamNo,
        },
      );

      // 서버 응답 후에 디버깅 로그 추가
      print('서버 응답 코드: ${response.statusCode}');
      print('서버 응답 데이터: ${response.data}');
      /*----응답처리-------------------*/
      if (response.statusCode == 200) {
        //접속성공 200 이면
        print(response.data); // json->map 자동변경
        //return PersonVo.fromJson(response.data["apiData"]);
        Navigator.pushNamed(context, '/');
      } else {
        //접속실패 404, 502등등 api서버 문제
        throw Exception('api 서버 문제');
      }
    } catch (e) {
      //예외 발생
      throw Exception('Failed to load person: $e');
    }
  }
}

// 리스트 가져오기 dio 통신
Future<List<TeamVo>> getTeamList() async {
  try {
    var dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    final response = await dio.get('http://localhost:9000/phone3/teamlist');

    if (response.statusCode == 200) {
      List<TeamVo> teamList = [];
      for (int i = 0; i < response.data["apiData"].length; i++) {
        TeamVo teamVo = TeamVo.fromJson(response.data["apiData"][i]);
        teamList.add(teamVo);
      }
      print(teamList);
      return teamList;
    } else {
      throw Exception('api 서버 문제');
    }
  } catch (e) {
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
