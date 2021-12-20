import 'package:doctorcall/coreapp/routing/routes.dart';
import 'package:doctorcall/features/news_feature/models/news_response.dart';
import 'package:doctorcall/features/news_feature/repositories/news_repository.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<List<Datum>?> getNewsData() async {
    var _list = await NewsRepository.getNewsData();
    if(_list==null){
      Navigator.pushReplacementNamed(context, Routes.LOGIN);
    }
    return _list?.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: FutureBuilder(
        future: getNewsData(),
        builder: (context, AsyncSnapshot<List<Datum>?> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, index) {
                    Datum _item = snapshot.data![index];
                    var _spl =_item.title!.split(" ");
                    return Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Navigator.pushNamed(context, Routes.NEWS_DETAIL, arguments: _item);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(_item.imgUrl!),
                          ),
                          title: Text("${_spl[0]} ${_spl[1]} ${_spl[2]} ${_spl[3]} ${_spl[4]}"),
                          subtitle: Text(_item.tanggal!),
                          trailing: Icon(Icons.chevron_right),
                        ),
                        SizedBox(height: 16,),
                        Image.network(_item.imgUrl!),
                        SizedBox(height: 16,),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Text(_item.body!),
                        )
                      ],
                    );
                  })
              :
          Center(
            child: CircularProgressIndicator(),
          ) ;
        },
      ),
    );
  }
}
