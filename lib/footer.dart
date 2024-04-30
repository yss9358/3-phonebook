import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, //세로정렬
        children: [
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                print("키패드");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dialpad),
                  Text(
                    '키패드',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                print("연락처");
                Navigator.pushNamed(context, "/");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  Text(
                    '연락처',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                print("즐겨찾기");
                Navigator.pushNamed(context, "/star");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star),
                  Text(
                    '즐겨찾기',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: InkWell(
              onTap: () {
                print("그룹");
                Navigator.pushNamed(context, "/group");
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group),
                  Text(
                    '그룹',
                    style: TextStyle(fontSize: 12),
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
