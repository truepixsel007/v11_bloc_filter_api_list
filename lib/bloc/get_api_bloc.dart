import 'package:bloc/bloc.dart';

import '../model/api_model.dart';
import '../repository/get_api_responsitory.dart';
import '../utils/enums.dart';
import 'get_api_event.dart';
import 'get_api_state.dart';

class GetApiBloc extends Bloc<GetApiEvent, GetApiStates> {
  GetApiRepository getApiRepository = GetApiRepository();

  List<ApiModel> temgetList = [];

  GetApiBloc() : super(GetApiStates()) {
    on<GetApiFetched>(fetchApi);
    on<SearchItem>(_fitlerList);
  }

  void fetchApi(GetApiFetched event, Emitter<GetApiStates> emit) async {
    await getApiRepository
        .fetchApi()
        .then((value) {
          emit(
            state.copyWith(
              getApiStatus: GetApiStatus.success,
              message: 'Success',
              getList: value,
            ),
          );
        })
        .onError((error, stackTrace) {
          print(error);
          print(stackTrace);
          emit(
            state.copyWith(
              getApiStatus: GetApiStatus.failure,
              message: error.toString(),
            ),
          );
        });
  }

  void _fitlerList(SearchItem event, Emitter<GetApiStates> emit) async {
    if (event.stString.isEmpty) {
      emit(state.copyWith(temgetList: [], searchMessage: ''));
    } else {
      // temgetList =
      //     state.getList
      //         .where(
      //           (element) =>
      //               element.id.toString() ==
      //               event.stString.toString().toString(),
      //         )
      //         .toList();

      temgetList =
          state.getList
              .where(
                (element) => element.email.toString().toLowerCase().contains(
                  event.stString.toString().toLowerCase(),
                ),
              )
              .toList();

      if (temgetList.isEmpty) {
        emit(
          state.copyWith(
            temgetList: temgetList,
            searchMessage: 'No data found',
          ),
        );
      } else {
        emit(state.copyWith(temgetList: temgetList, searchMessage: ''));
      }
    }
  }
}
