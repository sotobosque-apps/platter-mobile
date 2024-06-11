import 'package:flutter/foundation.dart';
import 'package:platter/models/Recipe.dart';

class UserSessionNotifier extends ChangeNotifier {
  String username = "armando29@live.com";
  String userId = "1";
  String _homeSelection0 = "Trendy";
  String get homeSelection0 => _homeSelection0;
  Recipe? _recipe;
  bool _sessionOn = false;
  bool _openbottomoptions = false;
  bool _systemcheck = false;
  // one of ["LibraryScreen", "LibraryScreenBlock"]
  String _bottomOptions = "";
  String get bottomOptions => _bottomOptions;
  Recipe? get recipe => _recipe;
  bool get sessionOn => _sessionOn;
  bool get openbottomoptions => _openbottomoptions;
  bool get systemcheck => _systemcheck;
  bool _entryOn = false;
  bool get entryOn => _entryOn;
  Map<int, bool> _openedShoppingList = {};
  bool editMode = false;

  void homeSelectionUpdate(String value) {
     _homeSelection0 = value;
     notifyListeners();
  }

  bool openedShoppingItem(int index) =>
      editMode || (_openedShoppingList[index] ?? false);

  void clearOpenedShoppingList() {
    _openedShoppingList = {};
  }

  void openAllShoppingListItems(int length) {
    editMode = !editMode;
    notifyListeners();
  }

  void switchOpenedShoppingListItem(int index) {
    _openedShoppingList[index] =
        _openedShoppingList[index] == true ? false : true;
    notifyListeners();
  }

  List<String> getConfigurat1ion() {
    return ['a', 'b', 'c'];
  }

  List<String> getSelection() {
    return ['a', 'b', 'c'];
  }

  List<String> getUser() {
    return ['armando29@live.com', 'Sotoarmando'];
  }

  void logIn(String username, String password) {
    setLoginTrue();
  }

  void toggleToggleEntry() {
    _entryOn = !_entryOn;
    notifyListeners();
  }

  void setLoginTrue() {
    _sessionOn = true;
    notifyListeners();
  }

  void updateifDifferent(name) {
    bool isvalid = _bottomOptions != name;
    if (isvalid) {
      _bottomOptions = name;
      notifyListeners();
    }
  }

  void updateRecipeIdState(Recipe? id) {
    _recipe = id;
    notifyListeners();
  }

  void togglebottomoptions() {
    _openbottomoptions = !_openbottomoptions;
    notifyListeners();
  }

  void clearbottomoptions() {
    _openbottomoptions = false;
    notifyListeners();
  }

  void logOff() {
    _sessionOn = false;
    notifyListeners();
  }

  void toggleSystemCheck() {
    _systemcheck = !_systemcheck;
    notifyListeners();
  }

  void signUp(String mail) {}

  void updateSelection() {}

  void updateConfiguration() {}
}
