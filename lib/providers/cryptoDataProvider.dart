import 'package:exchange/models/AllCryptoModel.dart';
import 'package:exchange/network/apiProvider.dart';
import 'package:exchange/network/responseModel.dart';
import 'package:flutter/cupertino.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;

  getTopMarketCapData() async {
    state = ResponseModel.loading('data is loading');

    try {
      var response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('something was wrong');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('check your connection');
      notifyListeners();
    }
  }

  getTopGainersData() async {
    state = ResponseModel.loading('data is loading');

    try {
      var response = await apiProvider.getTopGainersData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('something was wrong');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('check your connection');
      notifyListeners();
    }
  }

  getTopLosersData() async {
    state = ResponseModel.loading('data is loading');

    try {
      var response = await apiProvider.getTopLosersData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('something was wrong');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('check your connection');
      notifyListeners();
    }
  }

  getAllData() async {
    state = ResponseModel.loading('data is loading');

    try {
      var response = await apiProvider.getAllData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.complete(dataFuture);
      } else {
        state = ResponseModel.error('something was wrong');
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error('check your connection');
      notifyListeners();
    }
  }
}
