import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';

@immutable
abstract class NewsState {}

abstract class NewsActionState extends NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedSuccessState extends NewsState {
  final List<NewsModel> newslist;
  NewsLoadedSuccessState({required this.newslist});
}

class NewsErrorState extends NewsState {}
