import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ride_tracker/core/api_constants.dart';
import 'package:ride_tracker/features/ride_history/models/ride_history_model.dart';

class RideHistoryAPIRepo {
  
  static Future<List<RideHistoryModel>> getRideHistory() async {
    try {
      final response = await Dio().get(
        APIConstants.getRideHistoryAPI,
        options: Options(
          headers: {
            'Authorization': APIConstants.apiToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }

        List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(response.data);
        List<RideHistoryModel> rideHistoryList =
            dataList.map((map) => RideHistoryModel.fromMap(map)).toList();

        return rideHistoryList;
      } else {
        throw Exception('Failed to load ride history');
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      return [];
    }
  }

  static Future<void> bookmarkStat(int id, bool newBookmarkedStatus) async {
    try {
      final response = await Dio().post(
        APIConstants.postBookmarkAPI,
        options: Options(
          headers: {
            'Authorization': APIConstants.apiToken,
          },
        ),
        data: {
          'route_id': id,
          'bookmark': !newBookmarkedStatus,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Bookmarked status updated successfully');
        }
      } else {
        throw Exception(
            'Failed to update bookmarked status. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }
}
