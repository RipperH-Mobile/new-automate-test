import 'package:flutter/material.dart';

class SliverFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) builder;

  const SliverFutureBuilder({
    super.key,
    required this.future,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // While waiting, return a box widget wrapped in SliverToBoxAdapter.
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        // When data is available, the builder returns a sliver.
        return builder(context, snapshot);
      },
    );
  }
}
