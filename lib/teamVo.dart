class TeamVo {

  int? teamNo;
  String? teamName;

  TeamVo({
    this.teamNo,
    this.teamName
  });

  factory TeamVo.fromJson(Map<String, dynamic> apiData) {
    return TeamVo(
      teamNo : apiData['teamNo'],
      teamName : apiData['teamName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamNo': teamNo,
      'teamName': teamName,

    };
  }
}