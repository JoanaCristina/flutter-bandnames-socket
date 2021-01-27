import 'package:meta/meta.dart';

class Band {

  String id;
  String name;
  int votes;

  Band({
  @required this.id,
  @required this.name,
  @required this.votes}):
  assert(id !=null, name!=null),
  assert(votes!=null);

  //factory -> recebe certo tipo de argumento e retorna uma nova instância da classe


    factory Band.fromMap( Map<String, dynamic> json)
    => Band(
      id:    json['id'],
      name:  json['name'],
      votes: json['votes']
    );





}