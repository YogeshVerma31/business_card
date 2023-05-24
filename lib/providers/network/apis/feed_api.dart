

import '../../../constants/app_constants.dart';
import '../../../data/sharedPreference/shared_preference.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_reprensentable.dart';

enum FeedAnum { postApi, category, likePost,disLikePost,getSubscriptionStatus,activateSubscription }

class FeedApi extends APIRequestRepresentable {
  final FeedAnum feedAnum;
  final String? id;
  final String? userId;

  FeedApi({required this.feedAnum, this.id,this.userId});

  @override
  get body {
    switch (feedAnum) {
      case FeedAnum.category:
        return '';
      case FeedAnum.postApi:
        return '';
      case FeedAnum.likePost:
        return {'post_id':id};
      case FeedAnum.disLikePost:
        return {'post_id':id};
    }
  }

  @override
  String get endpoint {
    switch (feedAnum) {
      case FeedAnum.category:
        return 'content/categories';
      case FeedAnum.postApi:
        return 'content/posts?category_id=$id';
      case FeedAnum.likePost:
        return 'content/likepost';
      case FeedAnum.disLikePost:
        return 'content/likepost';
      case FeedAnum.getSubscriptionStatus:
        return 'auth/subscription';
      case FeedAnum.activateSubscription:
        return 'auth/subscription';
    }
  }

  @override
  Map<String, String>? get headers {
    return {
      "Content-type": "application/json",
      "Authorization":
          'Token ' + SharedPreference().getString(AppConstants().authToken)
    };
  }

  @override
  HTTPMethod get method {
    switch (feedAnum) {
      case FeedAnum.postApi:
        return HTTPMethod.get;
      case FeedAnum.category:
        return HTTPMethod.get;
      case FeedAnum.likePost:
        return HTTPMethod.post;
      case FeedAnum.disLikePost:
       return HTTPMethod.delete;
      case FeedAnum.getSubscriptionStatus:
        return HTTPMethod.get;
      case FeedAnum.activateSubscription:
        return HTTPMethod.post;
    }
  }

  @override
  String get path => '';

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => APIEndpoint.baseApi + endpoint;

  @override
  String get contentType => '';
}
