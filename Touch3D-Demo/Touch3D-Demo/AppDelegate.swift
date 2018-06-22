
//
//  代码请参考：https://www.jianshu.com/p/d472c6350a1a
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        setupTouch3D(application)
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        guard let vc = window?.rootViewController as? ViewController else { return }
        if shortcutItem.type == "ONE" {
            let viewController = ViewController()
            viewController.string = "ONE"
            vc.present(viewController, animated: true, completion: nil)
        } else if shortcutItem.type == "TWO" {
            let viewController = ViewController()
            viewController.string = "TWO"
            vc.present(viewController, animated: true, completion: nil)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    private func setupTouch3D(_ application: UIApplication) {
        let cameraIcon = UIApplicationShortcutIcon(type: .compose)
        let cameraItem = UIApplicationShortcutItem(type: "ONE", localizedTitle: "拍照", localizedSubtitle: nil, icon: cameraIcon, userInfo: nil)
        
        let shareIcon = UIApplicationShortcutIcon(type: .share)
        let shareItem = UIApplicationShortcutItem(type: "TWO", localizedTitle: "分享", localizedSubtitle: nil, icon: shareIcon, userInfo: nil)
        
        application.shortcutItems = [cameraItem, shareItem]
    }
}

