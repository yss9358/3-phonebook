import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xffd6d6d6), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, //세로정렬
        children: [
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                // print("키패드");
                Navigator.pushNamed(context, "/dial");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dialpad,
                    color: Color(0xff737373),
                  ),
                  Text(
                    '키패드',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                // print("연락처");
                Navigator.pushNamed(context, "/");
                // Navigator.popUntil(context, (route) => route.isFirst);
                // Navigator.popUntil(context, (route) => false);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Color(0xff737373),
                  ),
                  Text(
                    '연락처',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                // print("즐겨찾기");
                Navigator.pushNamed(context, "/star");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Color(0xff737373),
                  ),
                  Text(
                    '즐겨찾기',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                // print("그룹");
                Navigator.pushNamed(context, "/group");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group,
                    color: Color(0xff737373),
                  ),
                  Text(
                    '그룹',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff737373),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
