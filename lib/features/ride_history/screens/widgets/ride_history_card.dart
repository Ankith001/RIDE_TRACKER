import 'package:flutter/material.dart';
import 'package:ride_tracker/core/constants.dart';

// ignore: must_be_immutable
class RideHistoryCard extends StatelessWidget {
  RideHistoryCard({
    required this.startLocation,
    required this.endLocation,
    required this.color,
    required this.locImage,
    required this.onTap,
    super.key,
  });

  String? startLocation;
  String? endLocation;
  String? locImage;
  Color color = Colors.grey;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  locImage ?? '',
                ),
                fit: BoxFit.cover),
            boxShadow: [boxShadow1, boxShadow1],
            color: Colors.black26,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              height: 71,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(startLocation ?? '')
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              size: 18,
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(endLocation ?? '')
                          ],
                        )
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      hoverColor: color,
                      borderRadius: BorderRadius.circular(25),
                      onTap: () => onTap(),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        child: Icon(
                          Icons.favorite,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
