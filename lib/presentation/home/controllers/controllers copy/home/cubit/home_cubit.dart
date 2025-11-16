import 'dart:async' show Timer;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late Timer timer;
  int currentIndex = 0;
  late int sliderLength;
  HomeCubit() : super(SliderInitial()) {
    startAutoSlide();
  }
  void startAutoSlide() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      currentIndex = (currentIndex + 1) % sliderLength;
      emit(SliderChanged(currentIndex));
    });
  }

  void changePage(int index) {
   
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}
