import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var homeRouter: HomeRouter?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .appBackground
    let navigationController = UINavigationController()
    let router = HomeRouter(navigationController: navigationController)
    self.homeRouter = router
    
    let homeViewController = router.start()
    navigationController.viewControllers = [homeViewController]
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}
