import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
class PushNotifications {
  static Future<String> getAccessTokens() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "beauty-connect-9d187",
      "private_key_id": "5a4b22a1835878a0f371d0da8ac821ffbe3d1f56",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCblBBI+tyAvq50\nayszPsoEEbSu3NgktycSiuBmkpsEntuY41G4qNIzGZYPHo+81s2sQ/P4bYhT19OC\n2n2GYhlwQkJ5srxc+IXrDmJEfqGZnx8otCz1Lnzv2RSjm+IzYQ4NqnwgstvU1pgL\n2tF5fmiIgMef1xb96aGC3EzbXxEHmu3UakGZzQj5fNr5K6tv1pAE+Ko9e1dwLMe1\nuGzjAzY2GWCD6p33Yau/Gy3FwArnOgbN+FqgBYOD6Ef9Zud1TSJaHNOo7r41JQj5\n1MXGOek4t2fVHenOmB79e6nHCKCvRGzDjFLHYaWi2AMELlJYChEy1mvEzKXaL4jP\nt7KJuppJAgMBAAECggEAEHiBLdzDHe0yBni3Et6NoBcoyA9w4ZgzToL95VYVi8xu\nprXAN9rFoCvQB2s+n+kkzp1GFbGw6mFxzstnWSQHGeul4oDx8KzN7rfv3t0CKkOe\nlp5WmSFyECltBjIxZSucA4XeTM7qt5J9d9nTbfecRQFPQQSSNlD27KX6jAn5QVLz\nHPafwH/4nJMoUXpXevkQPT3EQjP2iiGyOyeXViVn7TjLYLqV1Wb3y1/1S7/2jCtS\nfiCS4c1BOELvmY7IH6BHDqe/GWS/GeakdIr3whE1dUmGfAGnjWrBrKtmDhHQjTDi\nS/WcFXr9gp4KL1uj2nWifHCqt2zyQwfgrPZ4x40ZZQKBgQDOtfBUYin/0DHP5rHo\nQO7Skvpf7QUtutkV9zdjXTggDfDp7pPbsceJhVOzu+9Ms/qy+nbFu6+P6xy1BP3r\n9jdrzjAwbIkuHJHXnD71ySao61D6pFsS/Zgf9wW5IWp9FYBx/6On6iNBNuj8l5kN\n4HDujClT5B9mJj4cTcSHLEmqXQKBgQDArOYZtd8U1mTwic22s1FB4n3l9LDWqLon\nIx6IMLDcAKuSnWuyELxzJXxd4zYwdLBYj2H/XNFMENod2b5wLVWJuCSxb6I/z+XD\novRI/Z7i+MS3PcyM0SeVTMPbp12s+hP9r5dhxwBZt7DAGjeYypklhrocstEt9NI1\n7woVKVQo3QKBgQCDjsusCOXOB8UMGjj0Jg9ZOW3cC0+WcSqkjjhUJwoHbJf9anf0\nBMuHvLEu3NdKK+nMaxeYdQEhSXN1yf2JZaSUGiAVUZ5lGI3BeZGggCr4qvtY6a2F\nAp0FCwQ7dQb/IOYkp5ySy7MwWDAkQp+Ic2WsjMvotnE9Y+13ug7wMMGZiQKBgEJv\n2+/lnISM4MVoXvyunEhBlvPiCdAa4gV4wKBpWbKisIafrXD7AGAb/uRI4niW4+/F\nkR8CnFDERtGgMWBw4VvZmR1txt6GC04INH+upEjTStF8h7nOrP14ONjWvyBUIuyI\nzYQzoFVPV60F3UHcKi6cZDRdHG/iSVG7mRhu5cwpAoGADt/9KPsv15mRGeNqihFF\nNETy9JBe8tXRrnBCo/zx18ekEZGveaBwj7R1jmyzqNS4+A5BnbC5Z8vGwBKvpJDS\n1+e/GZNp68wSgUTfIcAx2HHfmk77V43W5wOEjPYLWmEJTl+c+HzS49GSNfDUwZeD\nUGEvc3YrZkW0WWXL0edOmOE=\n-----END PRIVATE KEY-----\n",
      "client_email": "talha-zubair@beauty-connect-9d187.iam.gserviceaccount.com",
      "client_id": "113184383599074051354",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/talha-zubair%40beauty-connect-9d187.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/userinfo.email',
    ];
    http.Client client = http.Client();
    auth.AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );
    client.close();
    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver(String deviceToken) async {
    final String serverKeyAccessToken = await getAccessTokens();
    log(serverKeyAccessToken);

  }
}


// String endPointFirebaseCloudMessaging = 'https://fcm.googleapis.com/v1/projects/beauty-connect-9d187/messages:send';
// final Map<String, dynamic> message = {
//   'message': {
//     'token': deviceToken,
//     'notification': {
//       'title': 'title is',
//       'body': 'body is'
//     },
//     // 'data':
//     // {
//     //   'tripID': tripId
//     // }
//   }
// };
//
// final http.Response response = await http.post(
//   Uri.parse(endPointFirebaseCloudMessaging),
//   headers: <String, String>{
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $serverKeyAccessToken'
//   },
//   body: jsonEncode(message),
// );
//
// if (response.statusCode == 200) {
//   print("notification sent");
// } else {
//   print("notification not sent ${response.statusCode}");
// }