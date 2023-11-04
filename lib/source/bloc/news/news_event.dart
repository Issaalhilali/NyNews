abstract class NewsEvent {}

class NewsDataEvent extends NewsEvent {
  String? section = 'all-sections';
  String? period = '30';

  NewsDataEvent({this.section, this.period});
}

class NewsSectionDataEvent extends NewsEvent {}
