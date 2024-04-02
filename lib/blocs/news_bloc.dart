import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:news_app/blocs/news_event.dart';
import 'package:news_app/blocs/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsRepository newsRepository;
  NewsBloc({
    required this.newsRepository,
  }) : super(NewsInitial()) {
    on<NewsInitialEvent>(newsInitialEvent);
  }

  FutureOr<void> newsInitialEvent(
      NewsInitialEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    List<NewsModel> newslist = [];
    newslist = await newsRepository.fetchNews();
    emit(NewsLoadedSuccessState(newslist: newslist));
  }
}
