import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookData extends Equatable {
  final String id;
  final String name;
  final String author;
  final String category;
  final String audio;
  final String pdf;
  final String image;

  const BookData({
    required this.id,
    required this.name,
    required this.author,
    required this.category,
    required this.audio,
    required this.pdf,
    required this.image,
  });

  BookData copyWith({
    String? id,
    String? name,
    String? author,
    String? category,
    String? audio,
    String? pdf,
    String? image,
  }) {
    return BookData(
      id: id ?? this.id,
      name: name ?? this.name,
      author: author ?? this.author,
      category: category ?? this.category,
      audio: audio ?? this.audio,
      pdf: pdf ?? this.pdf,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'author': author});
    result.addAll({'category': category});
    result.addAll({'audio': audio});
    result.addAll({'pdf': pdf});
    result.addAll({'image': image});

    return result;
  }

  factory BookData.fromJson(Map<String, dynamic> map, String id) {
    return BookData(
      id: id,
      name: map['name'],
      category: map['category'],
      audio: map['audio'],
      author: map['author'],
      pdf: map['pdf'],
      image: map['image'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'author': author, 'category': category, 'audio': audio, 'pdf': pdf, 'image': image};

  @override
  String toString() {
    return 'BookData(id: $id, name: $name, author: $author, category: $category, audio: $audio, pdf: $pdf, image: $image)';
  }

  @override
  List<Object> get props {
    return [id, name, author, category, audio, pdf, image];
  }

  factory BookData.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookData(
      id: doc.id,
      name: data['name'],
      author: data['author'],
      category: data['category'],
      audio: data['audio'],
      pdf: data['pdf'],
      image: data['image'],
    );
  }
}
