import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  final int id;
  final String title;
  final String author;
  final String lyrics;
  final String? chords;

  Song({
    required this.id,
    required this.title,
    required this.author,
    required this.lyrics,
    this.chords,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);

  @override
  String toString() => 'Song(id: $id, title: $title, author: $author)';
}
