import 'package:rxdart/rxdart.dart';

mixin ModularLoadingStream {
  final _isLoadingController = BehaviorSubject<bool>.seeded(false);
  Sink<bool> get inIsLoading => _isLoadingController.sink;
  Stream<bool> get outIsLoading => _isLoadingController.stream;
  bool get getIsLoading => _isLoadingController.valueWrapper.value;


  void loadingDispose() {
    _isLoadingController?.close();
  }

}