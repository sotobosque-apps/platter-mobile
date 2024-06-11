import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:platter/models/CurrentIp.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:platter/models/Jwt.dart';

class AppStatusNotifier extends ChangeNotifier {
  String domain = "http://192.168.100.199:8080/api";
  bool cached = true;
  Map? _routeArgs;
  CurrentIp? ip;
  String? _searchResultsImage;
  bool _searchResultsImageVisible = false;
  Jwt? _session;
  Box<Map<String, dynamic>>? _box;
  Box<List<dynamic>>? _listBox;

  Jwt? get session => _session;

  String get searchResultsImage =>
      _searchResultsImage ??
      'https://m.ftscrt.com/static/recipe/da0421f2-aa0f-4193-886e-ad03e3a8b760.jpg';
  bool get searchResultsImageVisible => _searchResultsImageVisible;

  get routeArgs => _routeArgs;
  final paths = {
    "register": "auth/local/register",
    "identify": "auth/local",
    "platterConfirmValidation": "platterConfirmValidation",
    "updaterecipeComment": "updaterecipeComment",
    "deleterecipeComment": "deleterecipeComment",
    "recipeComment": "recipeComment",
    "recipeCommentByRecipe": "recipeCommentByRecipe",
    "recipeLike": "recipeLike",
    "recipeShopping": "recipeShopping",
    "recipeLikebyUser": "recipeLikesByUser",
    "shoppingListsbyUser": "shoppingListsbyUser",
    "amazonProducts": "amazonProducts",
    "amazonDetail": "amazonDetail",
    "productRecomendations": "productRecomendations",
  };

  setSession(Jwt jwt) {
    _session = jwt;
  }

  Map<String, dynamic> data(String name) =>
      _box!.containsKey(name) ? _box!.get(name)! : {};

  List<dynamic> listdata(String name) =>
      _listBox!.containsKey(name) ? _listBox!.get(name)! : [];

  setSearchResultsImageVisible(bool visible) {
    _searchResultsImageVisible = visible;
    Future.delayed(Duration(milliseconds: 100), () { notifyListeners(); });
  }

  setSearchResultsImage(String image) {
    _searchResultsImage = image;
    Future.delayed(Duration(milliseconds: 100), () { notifyListeners(); });
  }

  setRouteArgs(Map? args) {
    _routeArgs = args;
  }

  disableCache() {
    cached = false;
  }

  enableCache() {
    cached = true;
  }

  static Future<void> headers(HttpClientRequest request,
      {String? body = ''}) async {
    // Optionally set up headers...
    // Optionally write to the request object...
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    // request.headers.set(HttpHeaders.authorizationHeader, "Bearer Key");
    request.write(body);
    // request.
  }

  String postRequest(
      String path, Map<String, dynamic> query, String? param, String body,
      {String? url}) {
    String queryString = Uri(queryParameters: query).query;
    String paramString = param != null ? "/$param?" : "?";
    String URL = url ?? "$domain/platterauth/$path$paramString$queryString";

    // if (cached == true && _box!.containsKey(URL)) {
    //   Future.delayed(Duration(milliseconds: 100), () { notifyListeners(); });
    //   return URL;
    // }

    request(URL, body, true);

    return URL;
  }

  String fetchRequest(
      String path, Map<String, dynamic> query, String? param, String body, {bool? isCached }  ) {
    String queryString = Uri(queryParameters: query).query;
    String paramString = param != null ? "/$param?" : "?";
    String URL = "$domain/platterauth/$path$paramString$queryString";

    if ((isCached ?? cached) == true && (_box!.containsKey(URL) || _listBox!.containsKey(URL))) {
      final stringResponse = _box!.get(URL) ?? _listBox!.get(URL);
      print("cached::stringResponse");
      print(jsonEncode(stringResponse));

      Future.delayed(Duration(milliseconds: 100), () { notifyListeners(); });
      return URL;
    }

    request(URL, body, false);

    return URL;
  }

  String fetchFatsecretRequest(
      String path, Map<String, dynamic> query, String? param, String body) {
    String queryString = Uri(queryParameters: query).query;
    String paramString = param != null ? "/$param?" : "?";
    String URL = "$domain/fatsecretsource$paramString$queryString";

    if (cached == true && _box!.containsKey(URL)) {
      final stringResponse = _box!.get(URL);
      print("cached::stringResponse");
      print(jsonEncode(stringResponse));

      Future.delayed(Duration(milliseconds: 100), () { notifyListeners(); });
      return URL;
    }

    request(URL, body, false);

    return URL;
  }

  Future<String> request(String URL, String body, bool? post) async {
    final Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: body.contains('{') ? 'application/json' : 'text/plain',
    };

    Uri url = Uri.parse(URL);

    HttpClient client = HttpClient();
    HttpClientRequest request;

    if (post == true) {
      request = await client.postUrl(url);
    } else {
      request = await client.getUrl(url);
    }
    // Set headers
    headers.forEach((key, value) {
      request.headers.set(key, value);
    });

    request.write(body);

    HttpClientResponse response = await request.close();

    final stringData = await response.transform(utf8.decoder).join();

    print("REQUESTED: $URL");
    print(stringData);

    if (response.statusCode == 200 &&
        stringData.contains('error') == false &&
        (stringData.contains('message') &&
                stringData.contains('code') &&
                post != true) ==
            false) {
      print(stringData);
      try {
        await _box!.put(URL, Map<String, dynamic>.from(jsonDecode(stringData)));
      } catch (e) {
        if (stringData.contains("[")) {
          print(stringData.contains("["));
          await _listBox!.put(
              URL, List<dynamic>.from(jsonDecode(stringData)));
        }
      }
    }

    Future.delayed(Duration(milliseconds: 100), () { notifyListeners(); });

    client.close();

    return stringData;
  }

  // GET platterConfirmValidation?{email}&{token}
  platterConfirmValidation(String email, String token) {
    var query = {"email": email, "token": token};
    return fetchRequest(paths['platterConfirmValidation']!, query, null, "");
  }

  // POST api/auth/local/registerrecipeLikebyUser
  // body = {username, email, password}
  identify(
      {String? username, required String email, required String password}) {
    final Map<String, dynamic> body = {
      'identifier': email,
      'password': password
    };
    String path = paths['identify']!;
    print(jsonEncode(body));
    return postRequest('', {}, '', '${jsonEncode(body)} ',
        url: '$domain/$path');
  }

  // POST api/auth/local/registerrecipeLikebyUser
  // body = {username, email, password}
  register(String username, String email, String password) {
    final Map<String, dynamic> body = {
      'username': username,
      'email': email,
      'password': password
    };
    String path = paths['register']!;
    print(jsonEncode(body));
    return postRequest('', {}, '', '${jsonEncode(body)} ',
        url: '$domain/$path');
  }

  // POST updaterecipeComment?{user}&{timestamp}&{comment}
  updaterecipeComment(
      String user, String timestamp, String comment, String updateComment) {
    var query = {
      "user": comment,
      "timestamp": timestamp,
      "comment": updateComment
    };
    return postRequest(paths['updaterecipeComment']!, query, null, "");
  }

  // POST deleterecipeComment?{user}&{timestamp}
  // body = {comment}
  deleterecipeComment(String user, String timestamp, String comment) {
    var query = {
      "user": user,
      "timestamp": timestamp,
    };
    return postRequest(paths['deleterecipeComment']!, query, null, comment);
  }

  // POST recipeComment/{recipeId}?user=""
  // body = {comment}
  recipeComment(String recipeId, String user, String comment) {
    var query = {
      "user": user,
    };
    return postRequest(paths['recipeComment']!, query, recipeId, comment);
  }

  // GET recipeCommentByRecipe/{recipe}
  recipeCommentByRecipe(String recipeId) {
    Map<String, dynamic> query = {};
    return fetchRequest(paths['recipeCommentByRecipe']!, query, recipeId, "", isCached:  false);
  }

  // POST recipeLike/{recipeId}?{user}
  // body = null
  recipeLike(String recipeId, String user, Map<String, dynamic> body) {
    Map<String, dynamic> query = {
      "user": user,
    };
    return postRequest(paths['recipeLike']!, query, recipeId, jsonEncode(body));
  }

  // POST recipeShopping/{recipeId}?{user}
  // body = {shoppingitems}
  recipeShopping(String recipeId, String user, String shoppingitems) {
    Map<String, dynamic> query = {
      "user": user,
    };
    return postRequest(
        paths['recipeShopping']!, query, recipeId, shoppingitems);
  }

  // GET recipeLikebyUser/{user}
  recipeLikebyUser(String user) {
    return fetchRequest(paths['recipeLikebyUser']!, {}, user, "", isCached:  false);
  }

  // GET shoppingListsbyUser/{user}
  shoppingListsbyUser(String user) {
    Map<String, dynamic> query = {
      "user": user,
    };
    return fetchRequest(paths['shoppingListsbyUser']!, query, null, "");
  }

  // GET amazonProducts/{keywords}
  amazonProducts(String keywords) {
    Map<String, dynamic> query = {};
    return fetchRequest(paths['amazonProducts']!, query, keywords, "");
  }

  // GET amazonDetail/{asin}
  amazonDetail(String asin) {
    Map<String, dynamic> query = {};
    return fetchRequest(paths['amazonDetail']!, query, asin, "");
  }

  // GET productRecomendations/{recipedata}
  productRecomendations(String recipedata) {
    Map<String, dynamic> query = {};
    return fetchRequest(paths['productRecomendations']!, query, recipedata, "");
  }

  Future initBox() async {
    if (_box != null && _listBox != null) {
      print('HIVE BOX $_box DEFAULTED INITIALIZED');
      return 0;
    }
    ;
    WidgetsFlutterBinding.ensureInitialized();

    final directory = await getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    Hive.deleteBoxFromDisk('myBox');

    var future = Hive.openBox<Map<String, dynamic>>('myBox');
    var future1 = Hive.openBox<List<dynamic>>('myListBox');

    final v = await future;
    final v1 = await future1;

    print('HIVE BOX INITIALIZED');
    _box ??= v;
    _listBox ??= v1;

    return future;
  }

  // GET /fatsecretsource/{method}?{...args}
  fatsecretConsumer(String method, Map<String, dynamic> query) {
    return fetchFatsecretRequest("", query, method, "");
  }

  init() async {
    const ipify = "https://api.ipify.org/?format=json";
    print(ipify);
    final stringContent = await request(ipify, "", false);
    print(stringContent);
    var currentIp = CurrentIp.fromJson(jsonDecode(stringContent));
    ip = currentIp;
    return currentIp;
  }

  currentWeather() {
    final query = Uri(queryParameters: {
      "q": ip?.ip ?? '',
      "lang": "eng",
      "key": "63fb99cb11be4a5095f132611243005"
    }).query;

    final endpoint = "https://api.weatherapi.com/v1/current.json?$query";

    request(endpoint, "", false);

    return endpoint;
  }

  static imgURL(String url, {String width = "1280", String height = "960"}) {
    final query =
        Uri(queryParameters: {'url': url, 'width': width, 'height': height})
            .query;
    String domain = "http://192.168.100.199:8080/api";
    return "$domain/resize/image.png?$query";
  }
}
