import 'package:flutter/material.dart';

class SliverAppBarWidget extends StatelessWidget {
  final String _image;
  final String _title;

  const SliverAppBarWidget({
    super.key,
    required String image,
    required String title,
  })  : _image = image,
        _title = title;

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
          _title,
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
                image: AssetImage(_image),
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
