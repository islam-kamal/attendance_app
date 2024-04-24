
import '../../../../../Base/network/network-mappers.dart';

abstract class AppState {
  get model =>null;
}
class Start extends AppState{

}

class Loading extends AppState{
  final String? indicator;
  Mappable? model;
  Loading({this.model , this.indicator});

  @override
  String toString() {
    return indicator!;

    // TODO: implement toString
  }
}

class Done extends AppState{
  Mappable? model;
  final String? indicator;
  List<dynamic>? general_model;
  var general_value;
  Done({this.model , this.indicator,this.general_model, this.general_value});

  @override
  String toString() {
    return indicator!;

    // TODO: implement toString
  }

}

class ErrorLoading extends AppState{
  Mappable? model;
  List<dynamic>? general_model;
  String? indicator;
  String? message;
  ErrorLoading({this.model,this.message,this.indicator,this.general_model});
  @override
  String toString() {
    return message!;
    // TODO: implement toString
  }

}



