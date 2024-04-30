import 'package:flutter/material.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff), // 앱 바 배경색
        title: Text("연락처 정보"), // 앱 바 제목
        actions: [
          // 편집 버튼
          Container(
            padding: EdgeInsets.all(10),
            child: ButtonTheme(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  // 편집_EditForm 동작 추가
                  Navigator.pop(context);
                },
                child: Text(
                  "편집",
                  style: TextStyle(
                      color: Color(0xff737373), fontSize: 15), // 버튼 텍스트 색상 및 크기
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),),
                  minimumSize: Size(100, 50), // 최소 크기 설정
                ),
              ),

            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 414,
          // 컨테이너 가로 크기
          height: 680,
          // 컨테이너 세로 크기
          padding: EdgeInsets.all(10),
          // 컨테이너 내부 여백
          color: Color(0xffffffff),
          // 컨테이너 배경색
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  "이예슬",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  // 이름 스타일
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.phone,
                      color: Color(0xff737373), // 아이콘 색상
                    ),
                    label: Text(
                      "전화",
                      style: TextStyle(
                          color: Color(0xff737373),
                          fontSize: 15), // 버튼 텍스트 색상 및 크기

                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),),
                      minimumSize: Size(130, 50),),

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
                          color: Color(0xff737373),
                          fontSize: 15), // 버튼 텍스트 색상 및 크기
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),),
                      minimumSize: Size(130, 50),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                      color: Color(0xff737373), // 아이콘 색상
                    ),
                    label: Text(
                      "즐겨찾기",
                      style: TextStyle(
                          color: Color(0xff737373),
                          fontSize: 15), // 버튼 텍스트 색상 및 크기
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),),
                      minimumSize: Size(130, 50),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),
              Container(
                  width: 414,
                  height: 100,
                  child: _buildInfoBox("전화번호", "010-1111-2222")), // 전화번호 정보 박스
              SizedBox(height: 20),
              Container(
                  width: 414,
                  height: 100,
                  child: _buildInfoBox("그룹", "친구")), // 그룹 정보 박스


              SizedBox(height: 30), // 뒤로가기, 삭제
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        // 뒤로가기 동작 추가
                        Navigator.pop(context);
                      },
                      child: Text(
                        "뒤로가기",
                        style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 20), // 버튼 텍스트 색상 및 크기
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),),
                        minimumSize: Size(200, 60),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),

                  ButtonTheme(
                    child: ElevatedButton(
                      onPressed: () {
                        // 삭제 동작 추가
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Color(0xff737373), // 배경 색상 설정
                            title: Text("삭제"),
                            content: Text("정말로 삭제하시겠습니까?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      color: Color(0xff000000)), // 버튼 텍스트 색상
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // 삭제 동작 수행
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "삭제",
                                  style: TextStyle(
                                      color: Color(0xff000000)), // 버튼 텍스트 색상

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
                            fontSize: 20), // 버튼 텍스트 색상 및 크기
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd6d6d6), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),),
                        minimumSize: Size(200, 60),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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




