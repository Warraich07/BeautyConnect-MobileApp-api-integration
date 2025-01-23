class VideoModel {
  String title;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String desc;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  VideoModel({
    required this.title,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.desc,
    required this.videoUrl,
    required this.profilePhoto,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "uid": uid,
        "profilePhoto": profilePhoto,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "desc": desc,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
      };

  static VideoModel fromSnap(snapshot) {
    return VideoModel(
      title: snapshot['title'],
      uid: snapshot['uid'],
      id: snapshot['id'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      desc: snapshot['desc'],
      videoUrl: snapshot['videoUrl'],
      profilePhoto: snapshot['profilePhoto'],
      thumbnail: snapshot['thumbnail'],
    );
  }
}
