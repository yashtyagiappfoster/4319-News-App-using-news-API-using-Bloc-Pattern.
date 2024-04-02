import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news_bloc.dart';
import 'package:news_app/blocs/news_event.dart';
import 'package:news_app/blocs/news_state.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/views/news_detail_mobile_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _launchUrl(String url) async {
    print(url);
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    newsBloc.add(NewsInitialEvent());
  }

  final NewsBloc newsBloc = NewsBloc(newsRepository: NewsRepository());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: width * 0.03),
                    child: Text(
                      "News App".toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.7),
                    width: width,
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: height * 0.08),
              child: BlocBuilder<NewsBloc, NewsState>(
                bloc: newsBloc,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case NewsLoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case NewsLoadedSuccessState:
                      final successState = state as NewsLoadedSuccessState;
                      return ListView.builder(
                        itemCount: successState.newslist.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (kIsWeb) {
                                print(successState.newslist[index].url);
                                _launchUrl(successState.newslist[index].url
                                    .toString());
                              } else {
                                print("Mobile tab switched");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      openUrl: successState.newslist[index].url
                                          .toString(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.grey,
                                    offset: Offset(0, 2),
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              height: height * 0.15,
                              margin: EdgeInsets.only(
                                  top: height * 0.01,
                                  bottom: height * 0.01,
                                  left: width * 0.02,
                                  right: width * 0.02),
                              child: Row(
                                children: [
                                  Container(
                                    width: width * 0.3,
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                          image: NetworkImage(successState
                                              .newslist[index].urlToImage
                                              .toString()),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Container(
                                    height: height * 0.15,
                                    width: width * 0.55,
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01,
                                    ),
                                    child: Text(
                                      successState.newslist[index].title
                                          .toString(),
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                    case NewsErrorState:
                      return const Center(
                        child: Text('Something Went Wrong'),
                      );

                    default:
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.teal,
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
