import 'CryptoData.dart';
import 'Status.dart';


class AllCryptoModel {
  AllCryptoModel({Status? status, Data? data}) {
    _status = status;
    _data = data;
  }

  AllCryptoModel.fromJson(dynamic json) {
    _status = json['status'] != null ? Status.fromJson(json['status']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Status? _status;
  Data? _data;

  Data? get data => _data;

  Status? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_status != null) {
      map['status'] = _status?.toJson();
    }
    return map;
  }
}


class Data {
  Data({
    List<CryptoData>? cryptoCurrencyList,
    String? totalCount,
  }) {
    _cryptoCurrencyList = cryptoCurrencyList;
    _totalCount = totalCount;
  }

  Data.fromJson(dynamic json) {
    if (json['cryptoCurrencyList'] != null) {
      _cryptoCurrencyList = [];
      json['cryptoCurrencyList'].forEach((v) {
        _cryptoCurrencyList?.add(CryptoData.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
  }

  List<CryptoData>? _cryptoCurrencyList;
  String? _totalCount;

  List<CryptoData>? get cryptoCurrencyList => _cryptoCurrencyList;

  String? get totalCount => _totalCount;

  set cryptoCurrencyList(List<CryptoData>? value) {
    _cryptoCurrencyList = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cryptoCurrencyList != null) {
      map['cryptoCurrencyList'] =
          _cryptoCurrencyList?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    return map;
  }
}
