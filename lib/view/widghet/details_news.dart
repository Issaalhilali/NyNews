// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nynews/consts/color.dart';
import 'package:nynews/consts/const_padd.dart';
import 'package:nynews/model/popular/popular.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class DetailsNews extends StatefulWidget {
  static String route = '/details';

  const DetailsNews({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsNews> createState() => _DetailsNewsState();
}

class _DetailsNewsState extends State<DetailsNews> {
  @override
  Widget build(BuildContext context) {
    Popular item = ModalRoute.of(context)?.settings.arguments as Popular;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(item, context),
                  ConstPadd.paddh8,
                  topImage(item),
                  ConstPadd.paddh10,
                  body(item, context),
                ],
              ),
            ),
          ),
        ));
  }

  //-------------------------------------- title
  title(Popular item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        item.title.toString(),
        style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18),
      ),
    );
  }

//---------------------------------------- body
  body(Popular item, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.abstract.toString(),
          style:
              Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 18),
        ),
        ConstPadd.paddh10,
        Text('source: ${item.source.toString()}'),
        Text('scetion: ${item.section.toString()}'),
        Text('by: ${item.byline.toString()}'),
        ConstPadd.paddh20,
        Align(
            alignment: Alignment.bottomRight,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.date_range,
                  color: CustomColors.grey,
                  size: 20,
                ),
                ConstPadd.paddw5,
                Text(
                  item.publishedDate.toString(),
                  style: const TextStyle(
                    color: CustomColors.grey,
                  ),
                ),
                ConstPadd.paddw5,
                IconButton(
                    onPressed: () {
                      Share.share(item.url.toString());
                    },
                    icon: const Icon(
                      Icons.share,
                      size: 20,
                    ))
              ],
            )),
      ],
    );
  }

//----------------------------------------- images
  topImage(Popular item) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * .9,
        height: 150,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl:
              '${item.media?.map((e) => e.mediaMetadata?.map((e) => e.url)).firstOrNull?.last}',
          placeholder: (context, url) => SizedBox(
            width: size.width * .5,
            height: 100,
            child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.yellow,
                child: const SizedBox()),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
