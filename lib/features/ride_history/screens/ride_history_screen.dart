import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ride_tracker/core/constants.dart';
import 'package:ride_tracker/features/ride_history/bloc/ride_history_bloc.dart';
import 'package:ride_tracker/features/ride_history/models/ride_history_model.dart';

import 'widgets/ride_history_card.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen>
    with TickerProviderStateMixin {

  // this variable determnines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;
  List<RideHistoryModel> historyList = [];
  // scroll controller
  late ScrollController _scrollController;

  final RideHistoryBloc rideHistoryBloc = RideHistoryBloc();
  @override
  void initState() {
    rideHistoryBloc.add(RideHistoryFetchEvent());
    _scrollController = ScrollController()
      ..addListener(() {
        double maxScroll = _scrollController.position.maxScrollExtent;
        double currentScroll = _scrollController.position.pixels;
        double delta = 200.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          rideHistoryBloc.add(RideHistoryFetchEvent(pagination: true));
        }

        if (_scrollController.offset >= 100) {
          if (_showBackToTopButton == false) {
            setState(() {
              _showBackToTopButton = true; // show the back-to-top button
            });
          }
        } else if (_showBackToTopButton) {
          setState(() {
            _showBackToTopButton = false; // hide the back-to-top button
          });
        }
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),
          title: const Text(
            'Suggested Routes',
            style: TextStyle(
              fontSize: 18,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white),
      body: Stack(
        children: [
          BlocConsumer<RideHistoryBloc, RideHistoryState>(
            bloc: rideHistoryBloc,
            listener: (context, state) {
              if (state is RideHistoryFetchSuccess) {
                historyList = state.rides;
                if (state.isUpdated) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text('Ride Bookmark Updated!')));
                }
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case RideHistoryLoadingState:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );

                default:
                  return ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) => RideHistoryCard(
                      onTap: () {
                        rideHistoryBloc.add(RideHistoryBookmarkStatus(
                            rideHistoryModel: historyList[index]));
                      },
                      startLocation: historyList[index].startLoc,
                      endLocation: historyList[index].endLoc,
                      color: historyList[index].bookmarked == true
                          ? Colors.red
                          : Colors.grey,
                      locImage: historyList[index].image,
                    ),
                    itemCount: historyList.length,
                  );
              }
            },
          ),
          // To show the loading for lazyload
          BlocBuilder<RideHistoryBloc, RideHistoryState>(
            bloc: rideHistoryBloc,
            builder: (context, state) {
              if (state is ShowPaginationLoader) {
                return const Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),

      // This is our back-to-top button
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              elevation: 6,
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
              onPressed: _scrollToTop,
              child: const Icon(Icons.keyboard_arrow_up)),
    );
  }
}
