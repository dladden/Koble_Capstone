//
//  SceneDelegate.swift
//  Koble
//
//  Created by Denys Ladden on 3/25/22.
//

import UIKit
//for autolofin to check for a local user. Firebase has a function which tracks
//if user has been logged in, lets use it
import FirebaseAuth
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    //first window when application openes when app is initialized
    var window: UIWindow?
    //Firebase autheticator listener
    var authListener: AuthStateDidChangeListenerHandle?
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //AUTOLOGIN Function called from Autologgin
        //print("Autologin")
        autoLogin()
        
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    //MARK: - Autologin
    //AUTOLOGIN Function
    func autoLogin(){
        //assigning the sate listner to the authListener
        authListener = Auth.auth().addStateDidChangeListener({ (auth, user) in
            //when logged out change the state of the listener so that it is not
            //listening any mmore (force unwrap bc it is an optional)
            Auth.auth().removeStateDidChangeListener(self.authListener!)
            //make sure the user exists in db then access the application
            if user != nil && userDefault.object(forKey: kCURRENTUSER) != nil{
                
                DispatchQueue.main.async {
                    self.goToApp()
                }//end DispatchQueue
                
            }
            
        })
        
        
    }//end func autoLogin
    
    //this function will be used to take the user to the Main View Controller
    private func goToApp(){
        //instentiating the TabBarController in storyboard as main view
        let MainViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "Main View Controller") as! UITabBarController
        //using the UIwindow varibale to set is as a root view
        self.window?.rootViewController = MainViewController
        
    }//end func goToApp

}//end class SceneDelegate

