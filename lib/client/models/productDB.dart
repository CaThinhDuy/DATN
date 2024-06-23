import 'package:flutter/material.dart';

class Product {
  List<Products>? products;

  Product({this.products});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? idType;
  String? imageUrl;
  String? name;
  String? description;
  double? price;
  double? cost;
  int? promotion;
  int? repository;
  DateUtils? postAt;
  int? deleted;

  Products(
      {this.idType,
      this.imageUrl,
      this.name,
      this.description,
      this.price,
      this.cost,
      this.promotion,
      this.repository,
      this.postAt,
      this.deleted});

  Products.fromJson(Map<String, dynamic> json) {
    idType = json['idType'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    cost = json['cost'];
    promotion = json['promotion'];
    repository = json['repository'];
    postAt = json['postAt'];
    deleted = json['deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idType'] = idType;
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['cost'] = cost;
    data['promotion'] = promotion;
    data['repository'] = repository;
    data['postAt'] = postAt;
    data['deleted'] = deleted;
    return data;
  }
}
