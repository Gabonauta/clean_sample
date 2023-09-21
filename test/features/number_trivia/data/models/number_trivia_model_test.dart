import 'dart:convert';

import 'package:clean_sample/features/number_trivia/data/models/number_trivia.dart';
import 'package:clean_sample/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
void main(){
final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "test text");
test("should be a subclass of NumberTrivia entity", () => {
  //assert

    expect(tNumberTriviaModel, isA<NumberTrivia>())
},

);


group("fromJson", ()  { 
test("should return a valid model when json number is a integer", ()   {
   final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
   final result = NumberTriviaModel.fromJson(jsonMap);
   expect(result, tNumberTriviaModel);
},);
test("should return a valid model when json number is regarded as a double", ()   {
   
   //arrange
   final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
   //act
   final result = NumberTriviaModel.fromJson(jsonMap);
   //assert
   expect(result, tNumberTriviaModel);
},);
},);

group("toJson", () {
  test("should return a Json map containing the proper data", (){
    //act
    final result = tNumberTriviaModel.toJson();
    final exprectedMap = {
      "text": "Test Text",
      "number": 1,
    };
    expect(result, exprectedMap);
  });
 });
}