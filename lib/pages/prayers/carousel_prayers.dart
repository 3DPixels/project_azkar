import 'package:flutter/material.dart';
import 'package:project_azkar/utils/app_images.dart';

class CarouselExample extends StatefulWidget {
  const CarouselExample({super.key});

  @override
  State<CarouselExample> createState() => _CarouselExampleState();
}

class _CarouselExampleState extends State<CarouselExample> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 180,
          child: CarouselView(
            itemSnapping: true,
            itemExtent: 330,
            shrinkExtent: 200,
            elevation: 3,
            children: ImageInfo.values.map((ImageInfo image) {
              return UncontainedLayoutCard(imageInfo: image);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({super.key, required this.imageInfo});

  final ImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        // LAYER 1: (Maintains the overflow look)
        ClipRect(
          child: OverflowBox(
            maxWidth: width * 5.2 / 8,
            minWidth: width * 5.2 / 8,
            child: Image(fit: BoxFit.cover, image: AssetImage(imageInfo.url)),
          ),
        ),

        // LAYER 2: The Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xE6000000), Color(0x00000000)],
              ),
            ),
          ),
        ),

        // LAYER 3: The Text Content
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                imageInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                imageInfo.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFD1D5DB),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UncontainedLayoutCard extends StatelessWidget {
  const UncontainedLayoutCard({super.key, required this.imageInfo});

  final ImageInfo imageInfo;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;

    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        OverflowBox(
          maxWidth: width * 7 / 8,
          minWidth: width * 7 / 8,
          child: Image(fit: BoxFit.cover, image: AssetImage(imageInfo.url)),
        ),
        // LAYER 2: The Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xE6000000), Color(0x00000000)],
              ),
            ),
          ),
        ),

        // LAYER 3: The Text Content
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                imageInfo.title,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                imageInfo.subtitle,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFD1D5DB),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum ImageInfo {
  image0(
    'صلاة الكسوف',
    'طريقة صلاة الكسوف || اضغط هنا',
    AppImages.prayerKhusuf,
  ),
  image1('صلاة الوتر', 'طريقة صلاة الوتر || اضغط هنا', AppImages.prayerWetr),
  image2('صلاة الضحى', 'طريقة صلاة الضحى || اضغط هنا', AppImages.prayerDuha);

  const ImageInfo(this.title, this.subtitle, this.url);

  final String title;
  final String subtitle;
  final String url;
}
