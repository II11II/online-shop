import 'package:flutter/foundation.dart';
import 'package:online_shop/data/cache.dart';
import 'package:online_shop/data/network.dart';

class Repository with Network, Cache {
  static Repository _repository = Repository._();

  Repository._();

  factory Repository() {
    return _repository;
  }
}
