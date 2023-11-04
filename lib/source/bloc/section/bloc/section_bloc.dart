// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:nynews/model/section/sections.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/source/repository/section_repository.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final ISectionRepository _iSectionRepository = locator.get();

  SectionBloc() : super(SectionInitial()) {
    on<SectionDataEvent>(_getSection);
  }

  // -----------------------------------------------------------------------------
  void _getSection(SectionDataEvent event, Emitter<SectionState> emit) async {
    emit(SectionLoadingState());
    final sectionList = await _iSectionRepository.getSections();

    emit(SectionRequestSuccessState(sectionList));
  }
}
