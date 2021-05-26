import 'package:FaceNetAuthentication/src/ressources/UsersRepository.dart';
import 'package:FaceNetAuthentication/src/models/users.dart';

import '';
import 'package:rxdart/rxdart.dart';


class MoviesBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<Users>();

  Stream<Users> get allMovies => _moviesFetcher.stream;

  fetchAllUsers() async {
    Users itemModel = await _repository.fetchAllUsers();
      _moviesFetcher.sink.add(itemModel);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MoviesBloc();