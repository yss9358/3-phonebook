class PersonVo {

  int? personNo;
  String? name;
  String? hp;
  int? teamNo;
  bool? star;
  String? teamName;

  PersonVo({
    this.personNo,
    this.name,
    this.hp,
    this.teamNo,
    this.star,
    this.teamName,
  });

  factory PersonVo.fromJson(Map<String, dynamic> apiData) {
    return PersonVo(
      personNo: apiData['personNo'],
      name: apiData['name'],
      hp: apiData['hp'],
      teamNo: apiData['teamNo'],
      star: apiData['star'],
      teamName: apiData['teamName'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'personNo': personNo,
      'name': name,
      'hp': hp,
      'teamNo': teamNo,
      'star': star,
      'teamName': teamName,
    };
  }
}