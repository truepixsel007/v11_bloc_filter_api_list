import 'package:equatable/equatable.dart';

import '../model/api_model.dart';
import '../utils/enums.dart';

class GetApiStates extends Equatable {
  final GetApiStatus getApiStatus;
  final List<ApiModel> getList;
  final String message;
  final List<ApiModel> temgetList;
  final String searchMessage;

  GetApiStates({
    this.getApiStatus = GetApiStatus.loading,
    this.getList = const <ApiModel>[],
    this.message = '',
    this.temgetList = const <ApiModel>[],
    this.searchMessage = '',
  });

  GetApiStates copyWith({
    GetApiStatus? getApiStatus,
    List<ApiModel>? getList,
    String? message,
    List<ApiModel>? temgetList,
    String? searchMessage,
  }) {
    return GetApiStates(
      getList: getList ?? this.getList,
      getApiStatus: getApiStatus ?? this.getApiStatus,
      message: message ?? this.message,
      temgetList: temgetList ?? this.temgetList,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }

  @override
  List<Object?> get props => [
    getApiStatus,
    getList,
    message,
    temgetList,
    searchMessage,
  ];
}
