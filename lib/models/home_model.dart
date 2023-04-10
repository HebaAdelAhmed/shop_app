import 'package:flutter/material.dart';

class HomeModel{
  late bool status;
  HomeDataModel ? data;

  HomeModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel{

  List<Map<String , dynamic>> banners  = [];
  List<Map<String , dynamic>> products = [];

  List<BannerModel> bannerList = [];
  List<ProductModel> productList = [];

  HomeDataModel.fromJson(Map<String , dynamic> json){

    // banners = BannerModel.fromJson(json['banners']);
    // products = ProductModel.fromJson(json['products']);
    json['banners'].forEach((element)
    {
      bannerList.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element)
    {
      productList.add(ProductModel.fromJson(element));
    });

    json['banners'].forEach((element){
      banners.add(element);
    });
    json['products'].forEach((element){
      products.add(element);
    });
  }
}

class BannerModel{

  int ? id;
  String ? image;


  BannerModel.fromJson(Map<String , dynamic> json){

    id = json['id'];
    image = json['image'];
  }

}

class ProductModel{

  int ? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ? image;
  String ? name;
  bool ? inFavorites;
  bool ? inCart;

  ProductModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}