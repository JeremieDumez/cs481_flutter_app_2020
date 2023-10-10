enum SearchWindowType {
  all,
  day,
  week,
  month,
  year
}

String windowTypeName(SearchWindowType type) {
  switch (type) {
    case SearchWindowType.all:
      return "All";
    case SearchWindowType.day:
      return "Day";
    case SearchWindowType.week:
      return "Week";
    case SearchWindowType.month:
      return "Month";
    case SearchWindowType.year:
      return "Year";
    default:
      return "Undefined";
  }
}

int windowTypeIndex(SearchWindowType type) {
  switch (type) {
    case SearchWindowType.all:
      return 0;
    case SearchWindowType.day:
      return 1;
    case SearchWindowType.week:
      return 2;
    case SearchWindowType.month:
      return 3;
    case SearchWindowType.year:
      return 4;
    default:
      return 5;
  }
}

class PostAccountSettings {
  DataAccountSettings data;
  bool success;
  int status;

  PostAccountSettings({
    this.data,
    this.success: false,
    this.status,
  });

  factory PostAccountSettings.fromJson(
          Map<String, dynamic> json, Map<String, dynamic> base) =>
      PostAccountSettings(
        data: DataAccountSettings.fromJson(json["data"], base["data"]),
        success: json["success"],
        status: json["status"],
      );
}

class PostGalleryImages {
  List<GalleryImage> data;
  bool success;
  int status;

  PostGalleryImages({
    this.data,
    this.success: false,
    this.status,
  });

  factory PostGalleryImages.fromJson(Map<String, dynamic> json) =>
      PostGalleryImages(
        data: List<GalleryImage>.from(
            json["data"].map((x) => GalleryImage.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );
}

class DataAccountSettings {
  String accountUrl;
  String email;
  String avatar;
  String cover;
  bool publicImages;
  String albumPrivacy;
  bool acceptedGalleryTerms;
  bool newsletter;
  bool showMature;
  bool showViral;
  String bio;
  String reputation;
  String reputationName;
  DateTime created;

  DataAccountSettings(
      {this.accountUrl,
      this.email,
      this.avatar,
      this.cover,
      this.publicImages,
      this.albumPrivacy,
      this.acceptedGalleryTerms,
      this.newsletter,
      this.showMature,
      this.showViral,
      this.bio,
      this.reputation,
      this.reputationName,
      this.created});

  factory DataAccountSettings.fromJson(
          Map<String, dynamic> json, Map<String, dynamic> base) =>
      DataAccountSettings(
          accountUrl: json["account_url"],
          email: json["email"],
          avatar: base["avatar"],
          cover: base["cover"],
          publicImages: json["public_images"],
          albumPrivacy: json["album_privacy"],
          acceptedGalleryTerms: json["accepted_gallery_terms"],
          newsletter: json['newsletter_subscribed'],
          showMature: json['show_mature'],
          showViral: true,
          bio: base["bio"] == null
              ? "Tell Imgur a little about yourself"
              : base["bio"],
          reputation: base["reputation"].toString(),
          reputationName: base["reputation_name"],
          created:
              new DateTime.fromMillisecondsSinceEpoch(base['created'] * 1000));
}

class GalleryImage {
  String id;
  String link;
  String title;
  String description;
  int width;
  int height;
  String type;
  DateTime published;
  int views;
  int ups;
  int downs;
  String vote;
  bool favorite;
  bool nsfw;

  GalleryImage(
      {this.id,
      this.link,
      this.title,
      this.description,
      this.width,
      this.height,
      this.type,
      this.published,
      this.views,
      this.ups,
      this.downs,
      this.vote,
      this.favorite,
      this.nsfw});

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
        id: json["id"],
        link: json["link"],
        title: json["title"],
        description: json['description'],
        width: json['width'],
        height: json['height'],
        type: json['type'],
        published:
            new DateTime.fromMillisecondsSinceEpoch(json['datetime'] * 1000),
        views: json['views'],
        ups: json['ups'] == null ? 0 : json['ups'],
        downs: json['downs'] == null ? 0 : json['downs'],
        vote: json['vote'],
        favorite: json['favorite'],
        nsfw: json['nsfw']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['title'] = this.title;
    data['description'] = this.description;
    data['width'] = this.width;
    data['height'] = this.height;
    data['type'] = this.type;
    data['published'] = this.published;
    data['views'] = this.views;
    data['ups'] = this.ups;
    data['downs'] = this.downs;
    data['vote'] = this.vote;
    data['favorite'] = this.favorite;
    data['nsfw'] = this.nsfw;
    return data;
  }
}
