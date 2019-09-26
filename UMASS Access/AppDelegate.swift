//
//  AppDelegate.swift
//  UMASS Access
//
//  Created by Akash Munjial on 6/20/19.
//  Copyright © 2019 Akash Munjial. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let owlMeta = "https://owl.oit.umass.edu/owl-c/register/owllogin.cgi?UserType=Student&Server=owl-"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
        if UserDefaults.standard.object(forKey: "OwlOptions") == nil {
            UserDefaults.standard.set(["Accounting and Information Systems": owlMeta+"isenbergschoolofmanagement",
                                       "Art History": owlMeta+"arthistory",
                                       "Astronomy": owlMeta+"astronomy",
                                       "Biochemistry And Molecular Biology": owlMeta+"biochemistry",
                                       "Biology": owlMeta+"biology",
                                       "Chemistry General": owlMeta+"chemistry",
                                       "Chemistry Organic": owlMeta+"organicchemistry",
                                       "Chemistry Upper Level": owlMeta+"chemistryupperlevel",
                                       "Classics": owlMeta+"classics",
                                       "Computer Science": owlMeta+"compsci",
                                       "Economics": owlMeta+"economics",
                                       "Education": owlMeta+"education",
                                       "Electrical and COnputer Engineering": owlMeta+"eleccompeng",
                                       "Entomology": owlMeta+"entomology",
                                       "Extension": owlMeta+"extension",
                                       "Finance": owlMeta+"isomfinance",
                                       "Foreign Language": owlMeta+"foreignlang",
                                       "Hospitality and Tourism Management": owlMeta+"hospitalitytourismmanagement",
                                       "Information Technology Program": owlMeta+"infotechprog",
                                       "Journalism": owlMeta+"journalism",
                                       "Mathematics": owlMeta+"mathematics",
                                       "Music and Dance": owlMeta+"musicanddance",
                                       "Nutrition": owlMeta+"nutrition",
                                       "Physics": owlMeta+"physics",
                                       "Resource Economics": owlMeta+"resourceeconomics",
                                       "Theater": owlMeta+"theater",
                                       "Center for Educational Assessment": owlMeta+"ctredassess",
                                       "UMass Amherst iExams": owlMeta+"iexams",
                                       "UMass Amherst Placement Exams": owlMeta+"mathplacement",
                                       "UMass Amherst Online Course Surveys (SRTI)": owlMeta+"umacontedonlinecourseeval",
                                       "UMass Amherst Senior Surveys": owlMeta+"umassamherstseniorsurvey",
                                       "Massachusetts Association of Conservation Commissions": owlMeta+"macc",
                                       "Amherst College Astronomy": owlMeta+"amherstcollegeastro",
                                       "Holyoke Community College Engineering": owlMeta+"hcceng",
                                       "UMass Boston General Chemistry": owlMeta+"umborgchem",
                                       "UMass Boston Organic Chemistry": owlMeta+"umborgchem",
                                       "UNCG Physics Department": owlMeta+"uncgphysics",
                                       "Center for Educational Software Development": owlMeta+"cesdmanager",
                                       "CI-Team": owlMeta+"citeam",
                                       "Sandbox": owlMeta+"geography",
                                       "Standard": owlMeta+"standard",
                                       "UMass Online Testing": owlMeta+"umoltest",
                                       "OWL Examples from Various Departments": owlMeta+"demo",
                                       "Training Demo": owlMeta+"trainingdemo"], forKey: "OwlOptions")
        }
        
        
        return true
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

