

import 'baseViewModel.dart';

class HomeViewModel extends BaseViewModel {
  // Api _api = locator<Api>();

  // List<Post> posts;

  // Future getPosts(int userId) async {
  //   setState(ViewState.Busy);
  //   posts = await _api.getPostsForUser(userId);
  //   posts = null;
  //   setState(ViewState.Idle);
  // }

  String getText() {
    return "Testing 12345";
  }
}
