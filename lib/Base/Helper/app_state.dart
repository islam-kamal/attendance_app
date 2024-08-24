
abstract class AppState {
  get model =>null;
}
class Start extends AppState{

}

class Loading extends AppState{
}

class Done extends AppState{
}

class ErrorLoading extends AppState{
  final String? message;
  ErrorLoading({this.message});
}



