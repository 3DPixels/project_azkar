import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:project_azkar/data/zekr_model.dart';

import 'azkar_page.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories Page')),
      body: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(categories.length, (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AzkarPage(
                              time: ZekrTime.day,
                              categories: Categories.angry,
                            ),
                          ),
                        );
                      },
                      child: Center(child: Text(categories[index])),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

final List<String> categories = [
  'اذكار الصباح',
  'اذكار المساء',
  'اذكار الصلاة',
  'اذكار يوميه',
];
