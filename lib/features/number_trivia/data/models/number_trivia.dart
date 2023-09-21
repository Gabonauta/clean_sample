import 'package:clean_sample/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia{
const NumberTriviaModel({required String text, required int  number}) : super(text: 'Test Text', number: 1,);
  factory NumberTriviaModel.fromJson(Map<String,dynamic> json){
    return NumberTriviaModel(text: json['text'], number: (json['number'] as num).toInt(),);
  }
  Map<String, dynamic> toJson(){
    return{
      'text' : text,
      'number': number,
    };
  }
}