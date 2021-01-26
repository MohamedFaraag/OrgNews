import 'package:flutter/material.dart';
import 'package:orgnews/helper/news.dart';
import 'package:orgnews/helper/news.dart';
import 'package:orgnews/model/articalModel.dart';
import 'package:orgnews/views/artical_news.dart';

class CategoriesNews extends StatefulWidget {
  final String category;

  const CategoriesNews({this.category});
  @override
  _CategoriesNewsState createState() => _CategoriesNewsState();
}

class _CategoriesNewsState extends State<CategoriesNews> {
  bool _loading = true;

  List<ArtiacleModel> art = new List<ArtiacleModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.get(widget.category);
    art = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Org'),
              Text(
                'News',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        body: _loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: art.length,
                          itemBuilder: (context, index) {
                            return BlogTitle(
                              imageUrl: art[index].urlToImage,
                              title: art[index].title,
                              desc: art[index].description,
                              url: art[index].url,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}

class BlogTitle extends StatelessWidget {
  final String imageUrl, title, desc, url;

  const BlogTitle({this.imageUrl, this.title, this.desc, this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
