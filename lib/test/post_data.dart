import 'dart:convert';

Post postFromJson(String str) {
  final jsonData = json.decode(str);
  return Post.fromJson(jsonData);
}

String postToJson(Post data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}


List<Post> allPostsFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Post>.from(jsonData.map((x) => Post.fromJson(x)));
}

String allPostsToJson(List<Post> data) {
  final dyn = new List<dynamic>.from(data.map((x) => x.toJson()));
  return json.encode(dyn);
}

class Post {
  int page;
  int limit;
  String type;
  String name;

  Post({
    this.page,
    this.limit,
    this.type,
    this.name,
  });

  factory Post.fromJson(Map<String, dynamic> json) => new Post(
    page: json["page"],
    limit: json["limit"],
    type: json["type"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "type": type,
    "name": name,
  };
}