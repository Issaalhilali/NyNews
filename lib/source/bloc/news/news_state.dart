part of 'news_bloc.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsRequestSuccessState extends NewsState {
  final List<Popular> popularList;

  NewsRequestSuccessState(
    this.popularList,
  );
}
