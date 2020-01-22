import 'package:equatable/equatable.dart';
import 'package:mock_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mock_app/features/number_trivia/presentation/bloc/number_trivia_state.dart';
import 'package:meta/meta.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}


class Empty extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Loading extends NumberTriviaState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  Loaded({@required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
