import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Gist {
  //{"description":"Example of a gist","public":false,"files":{"README.md":{"content":"Hello World"}}}
  String id;
  String description;
  bool public;
  FilleGist? file;
  Gist({
    required this.id,
    required this.description,
    required this.public,
    this.file,
  });

  static List<Gist> parseGistList(Map<String, dynamic> json) {
    final list = json as List;
    return list.map((e) => Gist.fromMap(e)).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //'id': id,
      'description': description,
      'public': public,
      'file': file?.toMap(),
    };
  }

  factory Gist.fromMap(Map<String, dynamic> map) {
    return Gist(
      id: map['id'] as String,
      description: map['description'] as String,
      public: map['public'] as bool,
      file: map['files'] != null
          ? FilleGist.fromMap(map['files'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Gist.fromJson(String source) =>
      Gist.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FilleGist {
  String nameFile = "main.dart";
  String? content;
  FilleGist({
    this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      nameFile: {'content': content},
    };
  }

  factory FilleGist.fromMap(Map<String, dynamic> map) {
    return FilleGist(
      content: map['main.dart'] != null
          ? map['main.dart']['raw_url'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilleGist.fromJson(String source) =>
      FilleGist.fromMap(json.decode(source) as Map<String, dynamic>);
}
