import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider with ChangeNotifier {
  late final Box box;
  bool isLoading = false;
  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  //*MAP SETTINGS
  bool _showNazvy = false;
  bool get getShowNazvy => _showNazvy;

  set setShowNazvy(bool value) {
    _showNazvy = value;
    box.put('showNazvy', value);
    notifyListeners();
  }

  String _defaultPodlazie = 'HBP0';
  String get getDefaultPodlazie => _defaultPodlazie;

  set setDefaultPodlazie(String value) {
    _defaultPodlazie = value;
    box.put('defaultPodlazie', value);
    notifyListeners();
  }

  List<String> _recentSearch = [];

  List<String> get recentSearch => _recentSearch;

  set recentSearch(List<String> value) {
    _recentSearch = value;
    box.put('searchRecent', _recentSearch);
    notifyListeners();
  }

  void addRecentSearch(String search) {
    if (_recentSearch.contains(search)) return;
    _recentSearch.add(search);
    recentSearch = _recentSearch;
  }

  void removeRecentSearch(String search) {
    if (!_recentSearch.contains(search)) return;
    _recentSearch.remove(search);
    recentSearch = _recentSearch;
  }

  bool isChangingPass = false;
  void toggleIsChangingPass() {
    isChangingPass = !isChangingPass;
    notifyListeners();
  }

  bool isChangingEduPass = false;
  void toggleIsChangingEduPass() {
    isChangingEduPass = !isChangingEduPass;
    notifyListeners();
  }

  Future<void> loadValues() async {
    toggleLoading();
    try {
      box = await Hive.openBox('settings');
    } catch (e) {}
    if (box.values.isEmpty) await setDefaultValues();
    _recentSearch = List<String>.from(await box.get('searchRecent'));
    _defaultPodlazie = await box.get('defaultPodlazie');
    _showNazvy = await box.get('showNazvy');
    toggleLoading();
    print(box.values);
  }

  Future<void> setDefaultValues() async {
    await box.put('showNazvy', false);
    await box.put('defaultPodlazie', 'HBP0');
    await box.put('searchRecent', []);

    print(box.values);
  }
}
