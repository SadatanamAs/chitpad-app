import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mock_data_service.dart';
import '../models/auth_models.dart';
import '../../app/providers/app_providers.dart';

class AuthRepository {
  final Ref ref;
  AuthRepository(this.ref);

  MockDataService get _mock => ref.read(mockDataServiceProvider);

  void signup(SignUpRequest request) {
    _mock.signup(request.email, request.password, request.username);
  }

  void login(LoginRequest request) {
    _mock.login(request.email, request.password);
  }

  void logout() {
    _mock.logout();
  }

  bool get isLoggedIn => _mock.isLoggedIn;
}
