class PrivateKey {
  static const String API_KEY = 'VoxOfS7vNDjW6Z4MdyVIOcV0916iffCQ';
  static const String BaseUrl = 'http://api.nytimes.com/';

  ///for popular
  static String getPopular({section, period}) =>
      'svc/mostpopular/v2/mostviewed/$section/$period.json';

  ///for all sections
  static String get getAllSections => 'svc/news/v3/content/section-list.json';
}
