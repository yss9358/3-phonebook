class TeamVo {

  int? teamNo;
  String? teamName;
  int? count;

  TeamVo({
    this.teamNo,
    this.teamName,
    this.count,
  });

  factory TeamVo.fromJson(Map<String, dynamic> apiData) {
    return TeamVo(
      teamNo : apiData['teamNo'],
      teamName : apiData['teamName'],
      count : apiData['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamNo' : teamNo,
      'teamName' : teamName,
      'count' : count
    };
  }
}