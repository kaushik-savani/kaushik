import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Dummyproducts extends StatefulWidget {
  const Dummyproducts({Key? key}) : super(key: key);

  @override
  State<Dummyproducts> createState() => _DummyproductsState();
}

class _DummyproductsState extends State<Dummyproducts> {

  List l=[];
  bool status=false;
  var price;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  getdata() async {
    try {
      var response =
      await Dio().get('https://dummyjson.com/products');
      print(response);
      l = (response.data['products']);
      price=response.data['skip'];
      setState(() {
        status = true;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: status?ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        dummy d=dummy.fromJson(l[index]);
        return ListTile(title: Text("${d.price}"),
        subtitle: Text("${price}"),);
      },) :Center(child: CircularProgressIndicator()),
    );
  }
}



class dummy {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  dummy(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images});

  dummy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discountPercentage'] = this.discountPercentage;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['thumbnail'] = this.thumbnail;
    data['images'] = this.images;
    return data;
  }
}
