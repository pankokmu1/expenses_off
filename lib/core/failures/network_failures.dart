import 'default_failure.dart';

class NoConnectionFailure implements DefaultFailure {
  @override
  String get message => 'Sem conexao com a internet';
}
