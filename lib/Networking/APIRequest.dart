import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'classes.dart';


Future<PostAccountSettings> getAccountSettings(String accessToken) async {
  print("getAccountSettings");
  PostAccountSettings error;
  final res = await http.get(
    "https://api.imgur.com/3/account/me/settings",
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  final base = await http.get(
    "https://api.imgur.com/3/account/me/",
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  if (res.statusCode == 200 && base.statusCode == 200)
    return PostAccountSettings.fromJson(json.decode(res.body), json.decode(base.body));
  else if (res.statusCode == 429) {
    print("getAccountSettings : Error 429");
    return error;
  } else {
    print("error : code : " + res.statusCode.toString());
    return error;
  }
}

List parseLinksAndAlbums(Map<String, dynamic> parseJson) {
    List l = [];
    for (var e in parseJson['data']) {
      if (e['is_album'] == false) {
        var id = e['id'];
        var type = e['type'].split('/')[1];
        if (type == 'mp4')
          type = 'gif';
        e['link'] = 'https://i.imgur.com/$id.$type';
        l.add(e);
      }
    }
    return l;
}

Future<PostGalleryImages> getAccountImages(String accessToken) async {
  print("getAccountImages");
  PostGalleryImages error;
  final res = await http.get(
    "https://api.imgur.com/3/account/me/images",
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  if (res.statusCode == 200) {
    return PostGalleryImages.fromJson(json.decode(res.body));
  } else if (res.statusCode == 429) {
    print("getAccountImages : Error 429");
    return error;
  }
  return error;
}

Future<PostGalleryImages> getGallerySearch(String sort, SearchWindowType window, int page,
    String search, String accessToken) async {
  print("getGallerySearch");
  String windowName = windowTypeName(window).toLowerCase();
  final res = await http.get(
    "https://api.imgur.com/3/gallery/search/" +
        sort +
        "/" +
        windowName +
        "/" +
        page.toString() +
        "?q_all=" +
        search,
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  if (res.statusCode == 200) {
    Map<String, dynamic> parseJson = json.decode(res.body);
    parseJson['data'] = parseLinksAndAlbums(parseJson);
    return PostGalleryImages.fromJson(parseJson);
  } else {
    print(json.decode(res.body));
    throw Exception('Failed to get Gallery Search');
  }
}

Future<PostGalleryImages> getGallery(String sort, String window, int page,
    bool viral, bool mature, String accessToken) async {

  final res = await http.get(
    'https://api.imgur.com/3/gallery/hot/' + 
      sort + '/' +
      window + '/'+
      page.toString() + '?' +
      'showViral' + viral.toString() +
      '&mature=' + mature.toString() +
      '&album_previews=true',
    headers: { HttpHeaders.authorizationHeader: 'Bearer ' + accessToken}
  );
  if (res.statusCode == 200) {
    Map<String, dynamic> parseJson = json.decode(res.body);
    parseJson['data'] = parseLinksAndAlbums(parseJson);
    return PostGalleryImages.fromJson(parseJson);
  }
  else {
    print(json.decode(res.body));
    throw Exception('Failed to get Gallery');
  }
}

Future<void> favoriteImage(String imgId, String accessToken) async {
  print("Favorite image");
  final res = await http.post(
    "https://api.imgur.com/3/image/" + imgId + "/favorite",
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  print("Upload result code : " + res.statusCode.toString());
}

Future<PostGalleryImages> getAccountFavorite(
    String userName, String accessToken) async {
  print("getAccountFavorite");
  PostGalleryImages error;
  final res = await http.get(
    "https://api.imgur.com/3/account/" + userName + "/favorites/",
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  if (res.statusCode == 200) {
    Map<String, dynamic> parseJson = json.decode(res.body);
    parseJson['data'] = parseLinksAndAlbums(parseJson);
    return PostGalleryImages.fromJson(parseJson);
  } else if (res.statusCode == 429) {
    print("getGallerySearch : Error 429");
    return error;
  }
  return error;
}

Future<bool> isImageFavorite(String accessToken, String id) async {
  final res = await http.get(
    "https://api.imgur.com/3/image/" + id,
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  if (res.statusCode == 200)
    return json.decode(res.body)['data']['favorite'];
  else if (res.statusCode == 429) {
    print("getGallerySearch : Error 429");
    return false;
  }
  return false;
}

Future<void> deleteImage(String imgId, String accessToken) async {
  print("Delete image");
  final res = await http.delete(
    "https://api.imgur.com/3/image/" + imgId,
    headers: {HttpHeaders.authorizationHeader: "Bearer " + accessToken},
  );
  print("Delete result code : " + res.statusCode.toString());
}

Future<void> addImageToFavorites(String id, String accessToken) async {
  print("addImageToFavorites");
  final response = await http.post(
      'https://api.imgur.com/3/image/' + id + '/favorite',
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + accessToken});
  if (response.statusCode != 200)
    throw Exception('Failed to add image to favorites');
}

Future<bool> postImage(File img, String accessToken) async {
  var req = http.MultipartRequest(
      "POST", Uri.parse("https://api.imgur.com/3/image"));
  req.headers["authorization"] = "Bearer " + accessToken;
  req.files
      .add(new http.MultipartFile.fromBytes('image', await img.readAsBytes()));
  var resp = await req.send();
  if (resp.statusCode == 200)
    return true;
  else {
    final respSTR = await resp.stream.bytesToString();
    print(respSTR);
    return false;
  }
}

Future<void> changeAccountSettings(String key, String value, String accessToken) async {
  final response = await http.put(
      'https://api.imgur.com/3/account/me/settings',
      headers: {HttpHeaders.authorizationHeader: 'Bearer ' + accessToken},
      body: {key: value}
      );
  if (response.statusCode == 200)
    print('Success to change account settings $key to $value');
  else
    throw Exception('to change account settings $key to $value');
}

Future<bool> addVoteToImage(String id, String vote, String accessToken) async {

  final response = await http.post('https://api.imgur.com/3/gallery/' + id + '/vote/'+ vote,
                                  headers: {
                                      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken
                                  });
  if (response.statusCode == 200) {
    print("You voted \"" + vote + "\" on \"" + id + "\"!");
    return json.decode(response.body)['success'];
  } else {
    print(json.decode(response.body));
    throw Exception('Failed to vote to an image');
  }
}