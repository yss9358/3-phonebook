import 'package:flutter/material.dart';

class EditForm extends StatelessWidget {
  const EditForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController hpController = TextEditingController();
    TextEditingController groupController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Text('회원정보 수정'),
      ),
      body: Container(
        width: 414, // 고정된 가로 크기
        height: 680, // 고정된 세로 크기
        color: Color(0xffffffff),
        //padding: EdgeInsets.all(3),
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
                      Icons.account_circle,
                      size: 50,
                      color: Color(0xff737373),
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                      width: 300,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: '이름을 입력해 주세요',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Color(0xff737373),
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                      width: 300,
                      child: TextFormField(
                        controller: hpController,
                        decoration: InputDecoration(
                          hintText: '전화번호를 입력해 주세요',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Color(0xff737373),
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                      width: 300,
                      child: TextFormField(
                        controller: groupController,
                        decoration: InputDecoration(
                          hintText: '그룹을 입력해 주세요',
                          border: OutlineInputBorder(),
                        ),
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
                          // 저장 동작 추가
                          // 사용자가 입력한 값을 nameController.text, hpController.text, groupController.text를 통해 얻을 수 있어요.
                          // 여기서는 간단하게 컨텍스트를 팝합니다.
                          Navigator.pop(context);
                        },
                        child: Text(
                          "저장",
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
      ),
    );
  }
}
