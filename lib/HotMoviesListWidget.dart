import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_douban/HotMovieData.dart';
import 'package:flutter_douban/HotMovieItemWidget.dart';
import 'package:http/http.dart' as http;

class HotMoviesListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotMoviesListWidgetState();
  }
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> {
  List<HotMovieData> hotMovies = new List<HotMovieData>();
  void _getData() async {
    List<HotMovieData> serverDataList = new List();
    var res = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E6%B7%B1%E5%9C%B3&start=0&count=10&client=&udid=');

    if (res.statusCode == 200) {
      var resJson = json.decode(res.body);
      print('resJson $resJson');
      for (dynamic data in resJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }

      setState(() {
        hotMovies = serverDataList;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  // void initState() {
  //   super.initState();
  //   var data = HotMovieData('反贪风暴4', 6.0, '林路德', '古天乐/郑嘉颖/林峰', 29013,
  //       'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551353482.webp');
  //   setState(() {
  //     hotMovies.add(data);
  //     hotMovies.add(data);
  //     hotMovies.add(data);
  //     hotMovies.add(data);
  //     hotMovies.add(data);
  //     hotMovies.add(data);
  //   });
  // }
  Widget build(BuildContext context) {
    if (hotMovies == null || hotMovies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
          itemCount: hotMovies.length,
          itemBuilder: (context, index) {
            return HotMovieItemWidget(hotMovies[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: Colors.black26,
            );
          },
        ),
        // child: Text('haha'),
      );
    }
  }
}
