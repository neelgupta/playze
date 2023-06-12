import 'dart:developer';

import 'package:flutter/material.dart';

import '../modal/class.dart';

class FilterProvider extends ChangeNotifier {
  int filterCategoryCount = 0;
  String searchString = "";

  List<dp> filteredCatdataList = [];

  void updateSearchData(String searchData) {
    searchString = searchData;

    log("searchString is :: $searchString");
    notifyListeners();
  }

  void updateFilterCount(int countValue) {
    filterCategoryCount = countValue;

    log("filterCategoryCount is :: $filterCategoryCount");
    notifyListeners();
  }

  void updateFilterDataList(List<dp> filterDataList) {
    filteredCatdataList = filterDataList;

    updateFilterCount(filteredCatdataList.length);

    log("filteredCatdataList is :: ${filteredCatdataList.length}");
    notifyListeners();
  }
}
