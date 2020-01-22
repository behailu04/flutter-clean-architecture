import 'package:equatable/equatable.dart';
import 'package:mock_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mock_app/features/number_trivia/presentation/bloc/number_trivia_event.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class InitialNumberTriviaState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber({this.numberString});

  @override
  // TODO: implement props
  List<Object> get props =>[numberString];

   
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}