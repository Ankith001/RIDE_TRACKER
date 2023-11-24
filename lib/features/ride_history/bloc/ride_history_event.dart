// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_history_bloc.dart';

@immutable
abstract class RideHistoryEvent {}

/// Initial Event Call
class RideHistoryFetchEvent extends RideHistoryEvent {
  final bool pagination;
  RideHistoryFetchEvent({
    this.pagination = false,
  });
}

class RideHistoryBookmarkEvent extends RideHistoryEvent {
  final bool bookmarkStatus;
  final int index;
  RideHistoryBookmarkEvent({
    required this.bookmarkStatus,
    required this.index,
  });
}

/// Bookmark/Favorite Status Event Call
class RideHistoryBookmarkStatus extends RideHistoryEvent {
  final RideHistoryModel rideHistoryModel;
  RideHistoryBookmarkStatus({
    required this.rideHistoryModel,
  });
}
