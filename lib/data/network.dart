import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_shop/exceptions/exceptions.dart';
import 'package:online_shop/model/create_customer_order.dart';
import 'package:online_shop/model/customer_orders_model.dart';
import 'package:online_shop/model/get_category_model.dart';
import 'package:online_shop/model/products.dart';
import 'package:online_shop/model/profile.dart';
import 'package:online_shop/repository/repository.dart';

mixin Network {
  static const _url = "https://shopping-spring.herokuapp.com";

  final _timeout = Duration(seconds: 100);

  final headers = {
    "Accept": "application/json",
    "content-type": "application/json"
  };

  headersWithToken() async =>
      {
        "Accept": "application/json",
        "content-type": "application/json",
        "tkn": await Repository().getUserToken()
      };

  /// Categories api
  Future<GetCategory> getCategories() async {
    final response = await http
        .get(
        "$_url/api/category", headers: await headersWithToken()
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return GetCategory.fromJson(result);
      else
        throw UnknownException({
          "status code": response.statusCode,
          "response body": response.body
        });
    } else if (response.statusCode == 404) {
      throw NotFoundException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(
          {"status code": response.statusCode, "response body": response.body});
    } else
      throw UnknownException(
          {"status code": response.statusCode, "response body": response.body});
  }

  Future<bool> addToFavorite(Product product) async {


    final response = await http
        .post(
        "$_url/profile/add2favorite", headers: await headersWithToken(),
        body: jsonEncode(product.toJson())
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return true;
      else
        throw UnknownException({
          "status code": response.statusCode,
          "response body": response.body
        });
    } else if (response.statusCode == 404) {
      throw NotFoundException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(
          {"status code": response.statusCode, "response body": response.body});
    } else
      throw UnknownException(
          {"status code": response.statusCode, "response body": response.body});
  }

  Future<bool> removeFromFavorite(int id) async {
    var body = {
      "id": id
    };
    final request =  http
        .Request("DELETE",
        Uri.parse("$_url/profile/del4favorite")

    );
    request.headers.addAll(await headersWithToken());
    request.body=jsonEncode(body);
   final response=await request.send().timeout(_timeout);
    var responseBody=   await response.stream.bytesToString();


    if (response.statusCode == 200) {
    final result = json.decode(responseBody);
    if (result["statusCode"] == 200)
    return true;
    else
    throw UnknownException( {"status code": response.statusCode, " responseBody": responseBody});
    } else if (response.statusCode == 404) {
    throw NotFoundException( {"status code": response.statusCode, " responseBody": responseBody});
    } else if (response.statusCode == 401) {
    throw InvalidTokenException( {"status code": response.statusCode, "responseBody": responseBody});
    } else if (response.statusCode >= 500) {
    throw ServerErrorException( {"status code": response.statusCode, "responseBody": responseBody});
    } else
    throw UnknownException( {"status code": response.statusCode, "responseBody": responseBody});
  }

  Future<Profile> register(String email, String password, String phone) async {
    var body = {"username": email, "password": password, "phone": phone};
    print(body);
    final response = await http
        .post("$_url/profile/register",
        headers: headers, body: json.encode(body))
        .timeout(_timeout);

    if (response.statusCode == 201) {
      return Profile.fromRawJson(response.body);
    } else if (response.statusCode == 404) {
      throw NotFoundException("register()");
    } else if (response.statusCode == 400) {
      throw UserExistException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("register()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("register()");
    } else
      throw UnknownException(
          {"status code": response.statusCode, "response body": response.body});
  }

  Future<Profile> login(String login, String password) async {
    var body = { "password": password, "username": login};

    final response = await http
        .post("$_url/lgn/authenticate",
        headers: headers, body: json.encode(body))
        .timeout(_timeout);
    if (response.statusCode == 200) {
      var jsonDecode = json.decode(response.body);
      return Profile.fromJson(jsonDecode['profile']);
    } else if (response.statusCode == 404) {
      throw NotFoundException("register()");
    } else if (response.statusCode == 400) {
      throw UserExistException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(
          {"status code": response.statusCode, "response body": response.body});
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(
          {"status code": response.statusCode, "response body": response.body});
    } else
      throw UnknownException(
          {"status code": response.statusCode, "response body": response.body});
  }

  Future<GetCategory> getCategoriesById(int id) async {
    final response = await http
        .get(
      "$_url/api/category/${id}",
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return GetCategory.fromJson(result);
      else
        throw UnknownException("getCategoriesById()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getCategoriesById()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getCategoriesById()");
    } else
      throw UnknownException("getCategoriesById()");
  }

  Future<GetCategory> getCategoriesByName(String name) async {
    final response = await http
        .get(
      "$_url/api/category/srch/${name}",
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return GetCategory.fromJson(result);
      else
        throw UnknownException("getCategoriesByName()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getCategoriesByName()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getCategoriesByName()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else
      throw UnknownException("getCategoriesByName()");
  }

  /// Customer order api
  Future<CustomerOrder> getCustomerOrders() async {
    print(await headersWithToken());
    final response = await http
        .get(
        "$_url/api/order", headers: await headersWithToken()
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return CustomerOrder.fromJson(result);
      else
        throw UnknownException(
            {"status code:": response.statusCode, "body": response.body});
    } else if (response.statusCode == 404) {
      throw NotFoundException(
          {"status code:": response.statusCode, "body": response.body});
    } else if (response.statusCode == 401) {
      throw InvalidTokenException(
          {"status code:": response.statusCode, "body": response.body});
    } else if (response.statusCode >= 500) {
      throw ServerErrorException(
          {"status code:": response.statusCode, "body": response.body});
    } else
      throw UnknownException(
          {"status code:": response.statusCode, "body": response.body});
  }

  Future<CustomerOrder> getOrderByRegion(String region) async {
    Map<String, String> header = {"region": region};
    final response = await http
        .get("$_url/api/order/region", headers: header)
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return CustomerOrder.fromJson(result);
      else
        throw UnknownException("getOrderByRegion()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getOrderByRegion()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getOrderByRegion()");
    } else
      throw UnknownException("getOrderByRegion()");
  }

  Future<CustomerOrder> createOrderCustomer(CreateCustomerOrder order) async {
    final response = await http
        .post("$_url/api/order", body: order.toJson())
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return CustomerOrder.fromJson(result);
      else
        throw UnknownException("createOrderCustomer()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("createOrderCustomer()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("createOrderCustomer()");
    } else
      throw UnknownException("createOrderCustomer()");
  }

  /// Products api
  Future<Products> favoriteProducts() async {
    final response = await http
        .get(
      "$_url/api/product/favorites",headers:await headersWithToken()
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return Products.fromJson(result);
      else
        throw UnknownException("getProducts()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getProducts()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getProducts()");
    } else
      throw UnknownException("getProducts()");
  }

  Future<Products> getProductsByCategory(int id, int page) async {
    // TODO : where to give id and page To header or to url
    final response = await http
        .get(
        "$_url/api/product/by-category?id=$id&page=$page",
        headers: await headersWithToken()
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return Products.fromJson(result);
      else
        throw UnknownException("getProductsByCategory()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getProductsByCategory()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getProductsByCategory()");
    } else
      throw UnknownException("getProductsByCategory()");
  }

  Future<Product> getProductsByPage(int limit, int page) async {
    // TODO : where to give id and page To header or to url
    final response = await http
        .get(
      "$_url/api/product/paging",
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return Product.fromJson(result["object"]);
      else
        throw UnknownException("getProductsByPage()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getProductsByPage()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getProductsByPage()");
    } else
      throw UnknownException("getProductsByPage()");
  }


  Future<Products> getPopularProducts() async {
    final response = await http
        .get(
        "$_url/api/product/fetch-products", headers: await headersWithToken()
    )
        .timeout(_timeout);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result["statusCode"] == 200)
        return Products.fromJson(result);
      else
        throw UnknownException("getPopularProducts()");
    } else if (response.statusCode == 404) {
      throw NotFoundException("getPopularProducts()");
    } else if (response.statusCode == 401) {
      throw InvalidTokenException("getCategories()");
    } else if (response.statusCode >= 500) {
      throw ServerErrorException("getPopularProducts()");
    } else
      throw UnknownException("getPopularProducts()");
  }
}
