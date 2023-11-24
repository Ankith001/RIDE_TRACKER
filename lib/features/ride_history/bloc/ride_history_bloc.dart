import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ride_tracker/features/ride_history/models/ride_history_model.dart';
import 'package:ride_tracker/features/ride_history/repo/ride_history_repo.dart';

part 'ride_history_event.dart';
part 'ride_history_state.dart';

/// Created by Ankith on 23/11/23
class RideHistoryBloc extends Bloc<RideHistoryEvent, RideHistoryState> {
  List<RideHistoryModel> list = [];

  RideHistoryBloc() : super(RideHistoryInitial()) {
    on<RideHistoryFetchEvent>(rideHistoryFetchEvent);
    on<RideHistoryBookmarkStatus>(rideHistoryBookmarkStatus);
  }

  /// Initial Ride History BusinessLogic
  FutureOr<void> rideHistoryFetchEvent(
      RideHistoryFetchEvent event, Emitter<RideHistoryState> emit) async {
    if (event.pagination) {
      emit(ShowPaginationLoader());
    } else {
      emit(RideHistoryLoadingState());
    }

    await Future.delayed(const Duration(seconds: 2));

    var res = await RideHistoryAPIRepo.getRideHistory();
    if (event.pagination) {
      list.addAll(res);
    } else {
      list = res;
    }
    emit(RideHistoryFetchSuccess(rides: list));
  }

  /// Bookmark/Favorite Status BusinessLogic
  FutureOr<void> rideHistoryBookmarkStatus(
      RideHistoryBookmarkStatus event, Emitter<RideHistoryState> emit) async {
    await RideHistoryAPIRepo.bookmarkStat(
        event.rideHistoryModel.id, event.rideHistoryModel.bookmarked);

    var index =
        list.indexWhere((element) => element.id == event.rideHistoryModel.id);
    list[index].bookmarked = !event.rideHistoryModel.bookmarked;
    emit(RideHistoryFetchSuccess(rides: list, isUpdated: true));
  }
}
