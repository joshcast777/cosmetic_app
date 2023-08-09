import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String image;
  final String title;

  const SliverAppBarWidget({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: colorScheme.tertiary,
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        background: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    colorScheme.background,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
