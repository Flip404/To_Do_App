import 'dart:convert';

ForceUpdate forceUpdateFromJson(String str) =>
    ForceUpdate.fromJson(json.decode(str));

String forceUpdateToJson(ForceUpdate data) => json.encode(data.toJson());

class ForceUpdate {
  ForceUpdate({
    this.id,
    this.name,
    this.description,
    this.force,
    this.recommend,
    this.gid,
    this.version,
    this.enName,
    this.enDescription,
  });

  int? id;
  String? name;
  String? description;
  bool? force;
  bool? recommend;
  String? gid;
  String? version;
  String? enName;
  String? enDescription;

  factory ForceUpdate.fromJson(Map<String, dynamic> json) => ForceUpdate(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        force: json["force"],
        recommend: json["recommend"],
        gid: json["gid"],
        version: json["version"],
        enName: json["en_name"],
        enDescription: json["en_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "force": force,
        "recommend": recommend,
        "gid": gid,
        "version": version,
        "en_name": enName,
        "en_description": enDescription,
      };
}
