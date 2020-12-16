import 'package:dio/dio.dart';
import 'package:movies_app/helpers/api_keys.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/users.dart';

class FireBaseHandler {
  //singleton :: !1 object made for this class !!
  static FireBaseHandler _instance = FireBaseHandler._private();
  FireBaseHandler._private();
  static FireBaseHandler get instance => _instance;

  Dio _dio = Dio();

  Future<void> addFavorite(Movie movie, Users user) async {
    String url =
        'https://moviesapp-route-default-rtdb.europe-west1.firebasedatabase.app/users/${user.userId}/favorites/${movie.id}.json';
    final params = {
      'auth': user.idToken,
    };
    await _dio.put(url, queryParameters: params, data: {
      'id': movie.id,
      'title': movie.title,
      'vote_average': movie.rating,
      'poster_path': movie.posterUrl.split('/').last,
      'backdrop_path': movie.backPosterUrl.split('/').last,
    });
  }

  // to save favorites ans show it when you open tha app again !!
  Future<List<Movie>> getFavorites(Users user) async {
    String url =
        'https://moviesapp-route-default-rtdb.europe-west1.firebasedatabase.app/users/${user.userId}/favorites.json';
    final params = {
      'auth': user.idToken,
    };
    Response response = await _dio.get(
      url,
      queryParameters: params,
    );
    //print(response.data);
    if (response.data != null) {
      List<Movie> favs = (response.data as Map).entries.map((e) {
        return Movie.fromJson(e.value);
      }).toList();
      return favs;
    } else {
      return [];
    }
  }

  Future<void> removeFavorite(Movie movie, Users user) async {
    String url =
        'https://moviesapp-route-default-rtdb.europe-west1.firebasedatabase.app/users/${user.userId}/favorites/${movie.id}.json';
    final params = {
      'auth': user.idToken,
    };
    await _dio.delete(url, queryParameters: params);
  }

  Future<Users> register(String email, String password) async {
    // we take url from fire base docs' rest api' page : docs >> refrence >> rest >>
    String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp';
    final params = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {'email': email, 'password': password, 'returnSecureToken': true},
    );
    return Users.fromJson(response.data);
  }

  Future<Users> logIn(String email, String password) async {
    // we take url from fire base docs' rest api' page : docs >> refrence >> rest >>
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword';
    final params = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(
      url,
      queryParameters: params,
      data: {'email': email, 'password': password, 'returnSecureToken': true},
    );
    return Users.fromJson(response.data);
  }

  Future<Users> refreshToken(Users user) async {
    String url = 'https://securetoken.googleapis.com/v1/token';
    final params = {
      'key': ApiKeys.firebaseKey,
    };
    Response response = await _dio.post(url, queryParameters: params, data: {
      'grant_type': 'refresh_token',
      'refresh_token': user.refreshToken,
    });
    user.refreshToken = response.data['refresh_token'];
    user.idToken = response.data['id_token'];
    user.expiryDate = DateTime.now()
        .add(Duration(seconds: int.parse(response.data['expires_in'])));
    // int.parse is very important to avoid any error !!
    return user;
  }
}
