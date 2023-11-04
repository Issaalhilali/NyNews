import 'package:bloc/bloc.dart';
import 'package:nynews/model/popular/popular.dart';
import 'package:nynews/source/bloc/news/news_event.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/source/repository/popular_repository.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final IPopularRepository _productRepository = locator.get();

  NewsBloc() : super(NewsInitial()) {
    on<NewsDataEvent>(_getPopular);
  }

  // -----------------------------------------------------------------------------
  void _getPopular(NewsDataEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoadingState());
    final productList = await _productRepository.getPopulars(
        section: event.section, period: event.period);
    emit(NewsRequestSuccessState(productList));
  }
}
