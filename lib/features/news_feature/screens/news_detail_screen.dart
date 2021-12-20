import 'package:doctorcall/features/news_feature/models/news_response.dart';
import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  final dynamic data;

  const NewsDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  _NesDetailScreenState createState() => _NesDetailScreenState();
}

class _NesDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var _item = widget.data as Datum;
    var _spl =_item.title!.split(" ");

    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
      ),
      body: Padding(padding: EdgeInsets.only(bottom: 16), child:
          ListView(
            children: [
              Image.network(_item.imgUrl!),
              SizedBox(height: 16,),
              Text(_item.tanggal!),
              SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(_item.body!),
              )
            ],
          )
      ),
    );
  }
}
