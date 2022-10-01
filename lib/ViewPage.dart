import 'dart:convert';

import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  int pageIndex = 0;
  List l = [];
  List l1 = [];
  List l2 = [];
  List item = [];

  Future<List> getBanner() async {
    var url = Uri.parse('https://audio-kumbh.herokuapp.com/api/v1/banner');
    var response = await http.get(url);
    print('banner : ${response.body}');
    l = jsonDecode(response.body);
    return l;
  }

  Future<List> getCategories() async {
    var url = Uri.parse(
        "https://audio-kumbh.herokuapp.com/api/v2/category/audiobook");
    var response = await http.get(url, headers: {
      'x-guest-token':
          'U2FsdGVkX1+WVxNvXEwxTQsjLZAqcCKK9qqQQ5sUlx8aPkMZ/FyEyAleosfe07phhf0gFMgxsUh2uDnDSkhDaAfn1aw6jYHBwdZ43zdLiTcZedlS9zvVfxYG67fwnb4U454oAiMV0ImECW1DZg/w3aYZGXZIiQ+fiO4XNa1y1lc0rHvjKnPkgrYkgbTdOgAfnxnxaNHiniWClKWmVne/0vO0s6Vh7HpC0lRjs0LKTwM='
      // set content-length
    });
    print('categories : ${response.body}');
    l1 = jsonDecode(response.body);
    return l1;
  }

  Future<List> getAudiobooks() async {
    var url =
        Uri.parse("https://audio-kumbh.herokuapp.com/api/v2/homepage/category");
    var response = await http.post(
      url,
      body: {"sectionfor": "audiobook"},
      headers: {
        'x-guest-token':
            'U2FsdGVkX1+WVxNvXEwxTQsjLZAqcCKK9qqQQ5sUlx8aPkMZ/FyEyAleosfe07phhf0gFMgxsUh2uDnDSkhDaAfn1aw6jYHBwdZ43zdLiTcZedlS9zvVfxYG67fwnb4U454oAiMV0ImECW1DZg/w3aYZGXZIiQ+fiO4XNa1y1lc0rHvjKnPkgrYkgbTdOgAfnxnxaNHiniWClKWmVne/0vO0s6Vh7HpC0lRjs0LKTwM='
        // set content-length
      },
    );
    print('audiobooks : ${response.body}');
    l2 = jsonDecode(response.body)["data"]['home_category_list'];
    return l2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List l = snapshot.data as List;
                      for (int i = 0; i < l.length; i++) {
                        banner b = banner.fromJson(l[i]);
                        item.add(b.photoUrl);
                      }
                      return FlutterCarousel(
                        items: item.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Stack(
                                children: [
                                  Container(),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 25.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage("${i}"),
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 170,
                          reverse: false,
                          autoPlay: true,
                          initialPage: 0,
                          aspectRatio: 16 / 9,
                          pageSnapping: true,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                          slideIndicator: CircularSlideIndicator(
                            indicatorBorderColor: Colors.black,
                            indicatorBackgroundColor: Colors.white
                          )
                        ),
                      );
                    }
                    return Center(
                      child: Text("Something went Wrong!!!"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                future: getBanner(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Categories",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List l1 = snapshot.data as List;
                      return SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: l1.length,
                          itemBuilder: (context, index) {
                            categories c = categories.fromJson(l1[index]);
                            return Stack(
                              children: [
                                Container(
                                    height: 100,
                                    width: 150,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Image.network(
                                      "${c.photoUrl}",
                                      fit: BoxFit.fill,
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15.0, top: 20),
                                  child: Text(
                                    "${c.name}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationStyle:
                                            TextDecorationStyle.solid),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15.0, top: 65),
                                  child: Text(
                                    "${c.count}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25.0, top: 65),
                                  child: Text("${c.type}",
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
                      );
                    }
                    return Center(
                      child: Text("Something went Wrong"),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                future: getCategories(),
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
                    style: TextStyle(fontSize: 18, color: Colors.brown.shade300),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 18, color: Colors.brown.shade300),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List l2 = snapshot.data as List;
                        dummy d = dummy.fromJson(l2[0]);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: d.idList!.length,
                          itemBuilder: (context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160,
                                    width: 105,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${d.idList![index].audioBookDpUrl}"),
                                            fit: BoxFit.fill)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5),
                                    child: SizedBox(
                                      width: 105,
                                      child: Text(
                                        "${d.idList![index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: SizedBox(
                                      width: 90,
                                      child: Text(
                                        "${d.idList![index].author}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ]);
                          },
                        );
                      }
                      return Center(
                        child: Text("Something went Wrong"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  future: getAudiobooks(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Picks",
                    style: TextStyle(fontSize: 18, color: Colors.brown.shade300),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(fontSize: 18, color: Colors.brown.shade300),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 300,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List l2 = snapshot.data as List;
                        dummy d = dummy.fromJson(l2[1]);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: d.idList!.length,
                          itemBuilder: (context, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160,
                                    width: 105,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${d.idList![index].audioBookDpUrl}"),
                                            fit: BoxFit.fill)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5),
                                    child: SizedBox(
                                      width: 105,
                                      child: Text(
                                        "${d.idList![index].name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: SizedBox(
                                      width: 90,
                                      child: Text(
                                        "${d.idList![index].author}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ]);
                          },
                        );
                      }
                      return Center(
                        child: Text("Something went Wrong"),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  future: getAudiobooks(),
                ),
              ),

            ],
          ),
        ),
      ),
    ));
  }
}

class banner {
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

  banner(
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

  banner.fromJson(Map<String, dynamic> json) {
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

class categories {
  String? sId;
  String? type;
  String? photoUrl;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? count;

  categories(
      {this.sId,
      this.type,
      this.photoUrl,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.count});

  categories.fromJson(Map json) {
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

class dummy {
  String? sId;
  List<IdList>? idList;

  dummy({this.sId, this.idList});

  dummy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['idList'] != null) {
      idList = <IdList>[];
      json['idList'].forEach((v) {
        idList!.add(new IdList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.idList != null) {
      data['idList'] = this.idList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdList {
  String? sId;
  String? audioBookDpUrl;
  String? name;
  String? tags;
  Category? category;
  String? author;
  String? publisher;
  String? description;
  String? reader;
  List<Files>? files;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isLock;
  bool? isNewAudiobook;
  String? authorDpUrl;
  String? language;

  IdList(
      {this.sId,
      this.audioBookDpUrl,
      this.name,
      this.tags,
      this.category,
      this.author,
      this.publisher,
      this.description,
      this.reader,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isLock,
      this.isNewAudiobook,
      this.authorDpUrl,
      this.language});

  IdList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    audioBookDpUrl = json['audioBookDpUrl'];
    name = json['name'];
    tags = json['tags'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    author = json['author'];
    publisher = json['publisher'];
    description = json['description'];
    reader = json['reader'];
    if (json['files'] != null) {
      files = <Files>[];
      json['files'].forEach((v) {
        files!.add(new Files.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isLock = json['isLock'];
    isNewAudiobook = json['isNewAudiobook'];
    authorDpUrl = json['authorDpUrl'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['audioBookDpUrl'] = this.audioBookDpUrl;
    data['name'] = this.name;
    data['tags'] = this.tags;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['author'] = this.author;
    data['publisher'] = this.publisher;
    data['description'] = this.description;
    data['reader'] = this.reader;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isLock'] = this.isLock;
    data['isNewAudiobook'] = this.isNewAudiobook;
    data['authorDpUrl'] = this.authorDpUrl;
    data['language'] = this.language;
    return data;
  }
}

class Category {
  String? sId;
  String? type;
  String? photoUrl;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? count;

  Category(
      {this.sId,
      this.type,
      this.photoUrl,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.count});

  Category.fromJson(Map<String, dynamic> json) {
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

class Files {
  String? fileType;
  String? sId;
  String? title;
  int? playCount;
  int? seconds;
  String? fileUrl;

  Files(
      {this.fileType,
      this.sId,
      this.title,
      this.playCount,
      this.seconds,
      this.fileUrl});

  Files.fromJson(Map<String, dynamic> json) {
    fileType = json['fileType'];
    sId = json['_id'];
    title = json['title'];
    playCount = json['playCount'];
    seconds = json['seconds'];
    fileUrl = json['fileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileType'] = this.fileType;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['playCount'] = this.playCount;
    data['seconds'] = this.seconds;
    data['fileUrl'] = this.fileUrl;
    return data;
  }
}
