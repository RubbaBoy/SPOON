
/// Represents a song, either queued or currently playing
class Song {
  final String id;
  final String name;
  final String album;
  final List<String> artists;
  final bool inQueue;
  final int length;
  final String imageUrl;
  final int upvotes;
  final int downvotes;

  const Song(this.id, this.name, this.album, this.artists, this.inQueue, this.length, this.imageUrl, this.upvotes, this.downvotes);

  Song.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      name = json['name'],
      album = json['album'],
      artists = json['artists'].cast<String>(),
      inQueue = json['inQueue'],
      length = json['length'],
      imageUrl = json['imageUrl'],
      upvotes = json['upvotes'],
      downvotes = json['downvotes'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'album': album,
    'artists': artists,
    'inQueue': inQueue,
    'length': length,
    'imageUrl': imageUrl,
    'upvotes': upvotes,
    'downvotes': downvotes,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
