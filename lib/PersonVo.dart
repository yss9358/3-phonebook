class PersonVo {

  int personNo;
  String name;
  String hp;
  int teamNo;
  int star;

  PersonVo({
    required this.personNo,
    required this.name,
    required this.hp,
    required this.teamNo,
    required this.star,
  });

  factory PersonVo.fromJson(Map<String, dynamic> apiData) {
    return PersonVo(
      personNo: apiData['personNo'],
      name: apiData['name'],
      hp: apiData['hp'],
      teamNo: apiData['teamNo'],
      star: apiData['star'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'personNo': personNo,
      'name': name,
      'hp': hp,
      'teamNo': teamNo,
      'star': star,
    };
  }
}