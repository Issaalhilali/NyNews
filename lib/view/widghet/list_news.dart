// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:nynews/consts/color.dart';
import 'package:nynews/consts/const_padd.dart';

import 'package:nynews/model/popular/popular.dart';
import 'package:nynews/source/bloc/news/news_bloc.dart';
import 'package:nynews/view/widghet/details_news.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  final String? searchQuery;
  const HomePage({
    Key? key,
    this.searchQuery,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoadingState) {
          return const Center(
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [CustomColors.blue],
                  strokeWidth: 2,
                ),
              ),
            ),
          );
        }
        if (state is NewsRequestSuccessState) {
          return SizedBox(
            height: 600,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.popularList
                  .where((element) => element.id
                      .toString()
                      .contains(widget.searchQuery.toString()))
                  .length,
              itemBuilder: (context, index) {
                var item = state.popularList[index];

                return Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, DetailsNews.route,
                              arguments: state.popularList[index]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title(item, context),
                            ConstPadd.paddh8,
                            topImage(item),
                            ConstPadd.paddh10,
                            body(item, context),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text('nothing data'),
          );
        }
      },
    );
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
  //---------------------------------------- body
  body(Popular item, BuildContext context) {
    return Column(
      children: [
        Text(
          item.abstract.toString(),
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 17, color: Colors.grey[800]),
        ),
        ConstPadd.paddh5,
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
            width: size.width * .9,
            height: 150,
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
