

abstract class AppEvent {}

class logoutClickEvent extends AppEvent{}

class loginClickEvent extends AppEvent{
  final String username;
  final String password;
  loginClickEvent({required this.username,required this.password});
}

