abstract class ComicsEvent {}

class FetchComicsEvent extends ComicsEvent {
  final int limit;
  FetchComicsEvent({this.limit = 50});
}
