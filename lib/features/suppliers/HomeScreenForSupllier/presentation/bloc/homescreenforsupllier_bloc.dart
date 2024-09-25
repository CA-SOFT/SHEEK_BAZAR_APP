import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homescreenforsupllier_event.dart';
part 'homescreenforsupllier_state.dart';

class HomescreenforsupllierBloc
    extends Bloc<HomescreenforsupllierEvent, HomescreenforsupllierState> {
  HomescreenforsupllierBloc() : super(HomescreenforsupllierInitial()) {
    on<HomescreenforsupllierEvent>((event, emit) {});
  }
}
