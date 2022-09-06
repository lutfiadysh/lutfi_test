import 'dart:convert';

class LocalData {
  final String name;
  final String age;

  LocalData({required this.name, required this.age});

  factory LocalData.fromJson(Map<String, dynamic> json) {
    return LocalData(name: json['name'], age: json['age']);
  }

  static Map<String, dynamic> toMap(LocalData localData) {
    return {
      'name': localData.name,
      'age': localData.age,
    };
  }

  static String encode(List<LocalData> localData) {
    return json.encode(
      localData.map<Map<String, dynamic>>((e) => LocalData.toMap(e)).toList(),
    );
  }

  static List<LocalData> decode(String localData) {
    return (json.decode(localData) as List<dynamic>)
        .map<LocalData>((e) => LocalData.fromJson(e))
        .toList();
  }
}
