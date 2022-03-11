abstract class NewsState {}

class InitialState extends NewsState{}
class ModeState extends NewsState{}
class ChangeBottomNavBar extends NewsState{}
class LoadingState extends NewsState{}
class BusinessState extends NewsState{}
class SportsState extends NewsState{}
class ScienceState extends NewsState{}
class SearchState extends NewsState{}
class ErrorState extends NewsState{
  final String error;
  ErrorState(this.error);
}