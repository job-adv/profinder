import 'package:flutter/material.dart';
import 'package:profinder/widgets/cards/snapshot_error.dart';
import 'package:profinder/widgets/progress/loader.dart';

class HorizontalList<T> extends StatelessWidget {
  final Future<List<T>> future;
  final Widget Function(T item) itemBuilder;
  final String errorMessage;
  final String emptyText;

  const HorizontalList({
    Key? key,
    required this.future,
    required this.itemBuilder,
    required this.errorMessage,
    required this.emptyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppLoading();
        } else if (snapshot.hasError) {
          return SnapshotErrorWidget(error: snapshot.error);
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 100, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return itemBuilder(snapshot.data![index]);
              },
            ),
          );
        } else {
          return Column(
            children: [
              Icon(
                Icons.format_list_bulleted,
                size: 40,
                color: Colors.grey,
              ),
              Text(emptyText),
            ],
          );
        }
      },
    );
  }
}
