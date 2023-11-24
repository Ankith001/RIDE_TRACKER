// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ride_history_bloc.dart';

@immutable
abstract class RideHistoryState {}

class RideHistoryInitial extends RideHistoryState {}

class RideHistoryLoadingState extends RideHistoryState {}

class ShowPaginationLoader extends RideHistoryState {}

/// Initial Success State of List of Rides
class RideHistoryFetchSuccess extends RideHistoryState {
  final List<RideHistoryModel> rides;
  final bool isUpdated;
  RideHistoryFetchSuccess({
    this.isUpdated = false,
    required this.rides,
  });
}
