import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  CarouselController controller = CarouselController();
  bool status = false;
  List l = [];
  List l1 = [];
  int pageIndex = 0;
  dummy? d;
  dummy1? d1;
  List item = [];
  List item1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    try {
      var response =
          await Dio().get('https://audio-kumbh.herokuapp.com/api/v1/banner');
      print(response);
      var response2 = await Dio().get(
        "https://audio-kumbh.herokuapp.com/api/v2/category/audiobook",
        options: Options(
          headers: {
            'x-guest-token':
                'U2FsdGVkX1+WVxNvXEwxTQsjLZAqcCKK9qqQQ5sUlx8aPkMZ/FyEyAleosfe07phhf0gFMgxsUh2uDnDSkhDaAfn1aw6jYHBwdZ43zdLiTcZedlS9zvVfxYG67fwnb4U454oAiMV0ImECW1DZg/w3aYZGXZIiQ+fiO4XNa1y1lc0rHvjKnPkgrYkgbTdOgAfnxnxaNHiniWClKWmVne/0vO0s6Vh7HpC0lRjs0LKTwM='
            // set content-length
          },
        ),
      );
      /*var response3 = await Dio().get(
        "https://audio-kumbh.herokuapp.com/api/v2/homepage/category",
        options: Options(
          headers: {
            'x-guest-token':
            'U2FsdGVkX1+WVxNvXEwxTQsjLZAqcCKK9qqQQ5sUlx8aPkMZ/FyEyAleosfe07phhf0gFMgxsUh2uDnDSkhDaAfn1aw6jYHBwdZ43zdLiTcZedlS9zvVfxYG67fwnb4U454oAiMV0ImECW1DZg/w3aYZGXZIiQ+fiO4XNa1y1lc0rHvjKnPkgrYkgbTdOgAfnxnxaNHiniWClKWmVne/0vO0s6Vh7HpC0lRjs0LKTwM='
            // set content-length
          },
        ),
      );*/
      print(response2.data);
      l = (response.data);
      l1 = response2.data;
      for (int i = 0; i < l.length; i++) {
        d = dummy.fromJson(l[i]);
        item.add(d!.photoUrl);
      }
      /*for (int i = 0; i < l1.length; i++) {
        d1 = dummy1.fromJson(l1[i]);
        //item1.add(d1!.photoUrl);
      }*/
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
      body: status
          ? SafeArea(
              child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                      items: item.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage("$i"))),
                                );
                          },
                        );
                      }).toList(),
                      carouselController: controller,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            pageIndex = index;
                            controller.jumpToPage(index);
                          });
                        },
                        height: 150,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        //autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        //enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CarouselIndicator(
                      cornerRadius: 10,
                      activeColor: Colors.black,
                      color: Colors.white,
                      count: l.length,
                      index: pageIndex,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: l1.length,
                      itemBuilder: (context, index) {
                        d1 = dummy1.fromJson(l1[index]);
                        return Stack(
                          children: [
                            Container(
                                height: 100,
                                width: 150,
                                //width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                //decoration: BoxDecoration(color: Colors.amber),
                                child: Image.network(
                                  "${d1!.photoUrl}",
                                  fit: BoxFit.fill,
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 20),
                              child: Text(
                                "${d1!.name}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationStyle: TextDecorationStyle.solid),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 65),
                              child: Text(
                                "${d1!.count}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, top: 65),
                              child: Text("${d1!.type}",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 105, top: 50),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: CircleAvatar(
                                    maxRadius: 12,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  )),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Audiobooks",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Most Popular",
                        style: TextStyle(
                            fontSize: 18, color: Colors.brown.shade300),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 18, color: Colors.brown.shade300),
                      ),
                    ],
                  ),
                  Expanded(child: Container())
                ],
              ),
            ))
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class dummy {
  String? sId;
  String? bannerFor;
  String? forId;
  String? photoUrl;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isLock;
  String? redirectTo;
  String? type;
  String? redirect;

  dummy(
      {this.sId,
      this.bannerFor,
      this.forId,
      this.photoUrl,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isLock,
      this.redirectTo,
      this.type,
      this.redirect});

  dummy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bannerFor = json['bannerFor'];
    forId = json['forId'];
    photoUrl = json['photoUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isLock = json['isLock'];
    redirectTo = json['redirectTo'];
    type = json['type'];
    redirect = json['redirect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bannerFor'] = this.bannerFor;
    data['forId'] = this.forId;
    data['photoUrl'] = this.photoUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isLock'] = this.isLock;
    data['redirectTo'] = this.redirectTo;
    data['type'] = this.type;
    data['redirect'] = this.redirect;
    return data;
  }
}

class dummy1 {
  String? sId;
  String? type;
  String? photoUrl;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? count;

  dummy1(
      {this.sId,
      this.type,
      this.photoUrl,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.count});

  dummy1.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    photoUrl = json['photoUrl'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['photoUrl'] = this.photoUrl;
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['count'] = this.count;
    return data;
  }
}
