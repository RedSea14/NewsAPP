import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NewsModel {
  int id;
  String title;
  String description;
  String content;
  String thumb;
  int category_id;
  String publish_date;
  String created_at;
  String updated_at;
  String author;
  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.thumb,
    required this.category_id,
    required this.publish_date,
    required this.created_at,
    required this.updated_at,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'thumb': thumb,
      'category_id': category_id,
      'publish_date': publish_date,
      'created_at': created_at,
      'updated_at': updated_at,
      'author': author,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      thumb: map['thumb'] as String,
      category_id: map['category_id'] as int,
      publish_date: map['publish_date'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      author: map['author'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
