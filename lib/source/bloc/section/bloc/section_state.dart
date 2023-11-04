part of 'section_bloc.dart';

abstract class SectionState {}

class SectionInitial extends SectionState {}

class SectionLoadingState extends SectionState {}

class SectionRequestSuccessState extends SectionState {
  final List<SectionsModel> sectionList;

  SectionRequestSuccessState(
    this.sectionList,
  );
}
