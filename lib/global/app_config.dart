
class AppConfig {
  AppConfig._();

  static const  appState = 'live'; 
  // static const  appState = 'dev'; 

  // Domain
  static const webUrl = (appState=='live')
                      ?'https://safehere.iworldtechsolutions.com'
                      :'http://192.168.100.5';
  static const baseUrl = '$webUrl/api/safehere'; 
  
  static const privacyPolicyUrl = ''; 
  static const termsConditionsUrl = ''; 
  
  // PusherBeams
  static const instanceIDPusherBeams = (appState=='live')
                      ?'154153e8-00fa-4dd8-937b-6e42e37536c5'
                      :'154153e8-00fa-4dd8-937b-6e42e37536c5';
  
  // Pusher CHannel
  static const apiKeyPusherChannel = (appState=='live')?'b357982f79ddd7713a97':'b357982f79ddd7713a97';
  static const clusterPusherChannel = 'ap1';

}