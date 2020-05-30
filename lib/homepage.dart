import 'package:flutter/material.dart';
import 'news.dart';
import 'package:intl/intl.dart';
import 'player_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  bool loadingInProgress;
  var newslist;

  void getNews() async{
    News news = News();
    await news.getNews();
    setState(() {
      loadingInProgress = false;
      newslist = news.news;
    });
  }

  @override
  void initState() {
    loadingInProgress = true;
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 20.0),
           child: loadingInProgress ? Center(child: Text('Loading...')) : 
           Column(
             children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Top Headlines', 
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold
                      )
                    ),
                ]
              ),
              Divider(),
              Expanded(
                  child: ListView.builder(
                    itemCount: newslist.length,
                    itemBuilder: (context,index) {
                      return ListTile(
                        leading: Image.network(newslist[index].urlToImage) == null ? Image.asset('assets/news.jpg') : Image.network(newslist[index].urlToImage),
                        title: Text(newslist[index].title),
                        subtitle: Text(DateFormat.Hm().format(newslist[index].publishedAt)),
                        trailing: PlayerWidget(body: newslist[index].content),
                    );
                  }
                ),
              )
             ],
           ),
          )
        ),
    );
  }
}