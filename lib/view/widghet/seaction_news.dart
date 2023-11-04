import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nynews/model/section/sections.dart';
import 'package:nynews/source/bloc/news/news_bloc.dart';
import 'package:nynews/source/bloc/news/news_event.dart';
import 'package:nynews/source/bloc/section/bloc/section_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HeadNews extends StatefulWidget {
  const HeadNews({super.key});

  @override
  State<HeadNews> createState() => _HeadNewsState();
}

class _HeadNewsState extends State<HeadNews> {
  @override
  void initState() {
    BlocProvider.of<SectionBloc>(context).add(SectionDataEvent());
    super.initState();
  }

  String _title = '';
  int? _isSelectedSection;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SectionBloc, SectionState>(
      builder: (context, state) {
        if (state is SectionLoadingState) {
          return SizedBox(
            width: 90.0,
            height: 47,
            child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.yellow,
                child: const SizedBox()),
          );
        }
        if (state is SectionRequestSuccessState) {
          return SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.sectionList.length,
              itemBuilder: (context, index) {
                String newString = 'all sections';
                state.sectionList
                    .setAll(0, [SectionsModel(section: newString)]);
                var item = state.sectionList[index];
                return InkWell(
                    onTap: () {
                      setState(() {
                        _title = item.section.toString();
                        context.read<NewsBloc>().add(NewsDataEvent(
                            section: _title.replaceAll(' ', '-'),
                            period: '30'));
                        _isSelectedSection = index;
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 5, bottom: 5),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: (_isSelectedSection == index)
                                ? Colors.green[200]
                                : Colors.grey[50]),
                        child: Text(item.section.toString())));
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
