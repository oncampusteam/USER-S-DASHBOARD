import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyABVlIHUzO87NqzOFFq4xyZ5fnl-Xs_SAQ")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
