import 'package:equatable/equatable.dart';

abstract class GetApiEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetApiFetched extends GetApiEvent {}

class SearchItem extends GetApiEvent {
  final String stString;
  SearchItem(this.stString);
}
