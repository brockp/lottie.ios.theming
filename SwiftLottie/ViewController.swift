//
//  ViewController.swift
//  SwiftLottie
//
//  Created by Brock Carrington Prescott on 10/26/21.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    // Create animation view variable based on Lottie's AnimationView
    var animationView: AnimationView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the animation
        animationView = .init(name: "TwitterHeart")
        // Determine the frame the animation sits in
        animationView?.frame = view.bounds
        // Add the subview (must do)
        view.addSubview(animationView!)
        
        // Lottie Options
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1.5
        
        // Arranging Element 
        view.sendSubviewToBack(animationView!)
        
        // Console log the animnations key paths (to understand our element references)
        animationView.logHierarchyKeypaths()
        
        let jsonName = "TwitterHeartButton"
        let animation = Animation.named(jsonName)!
        let markerNames = animation.markerNames
        for name in markerNames {
            print("Marker: \(name)")
            print("Frame: \(String(describing: animation.frameTime(forMarker: name)))")
            print("Progress: \(String(describing: animation.progressTime(forMarker: name)))")
            print("")
        }
        
        
        
        /***
         BEGIN PENROSE TRIANGLE THEME ADJUSTMENTS
         ***/
        
        // Create ColorValueProvider using Lottie's Color class
//        let bioticPink = Color(r: (200/255), g: (11/255), b: (202/255), a: 1)
//        let bioticPinkColorProvider = ColorValueProvider(bioticPink)
//        let keyPath = AnimationKeypath(keypath: "**.right-triangle.right-triangle.Fill 1.Color")
//        animationView.setValueProvider(bioticPinkColorProvider, keypath: keyPath)
//
//        let bioticPink60 = Color(r: (212/255), g: (99/255), b: (213/255), a: 1)
//        let bioticPink60ColorProvider = ColorValueProvider(bioticPink60)
//        let keyPath2 = AnimationKeypath(keypath: "**.left-triangle.left-triangle.Fill 1.Color")
//        animationView.setValueProvider(bioticPink60ColorProvider, keypath: keyPath2)
//
//        let bioticPink20 = Color(r: (223/255), g: (185/255), b: (223/255), a: 1)
//        let bioticPink20ColorProvider = ColorValueProvider(bioticPink20)
//        let keyPath3 = AnimationKeypath(keypath: "**.bottom-triangle.bottom-triangle.Fill 1.Color")
//        animationView.setValueProvider(bioticPink20ColorProvider, keypath: keyPath3)
//
//        // Change dots opacity (range 0 ~ 100)
//        let opacityValueProvider = FloatValueProvider(CGFloat(20))
//        let dotOpacityKeyPath = AnimationKeypath(keypath: "**.right-triangle.right-triangle.Fill 1.Opacity")
//        animationView.setValueProvider(opacityValueProvider, keypath: dotOpacityKeyPath)
//
        
        
        /***
         BEGIN TWITTER HEART THEME ADJUSTMENTS
         ***/
        
        // Scale up dots & ellipse
        let scaleValueProvider = SizeValueProvider(CGSize(width: 200, height: 200))
        let dotKeyPath = AnimationKeypath(keypath: "Dot*.Shape 1.Scale")
        animationView.setValueProvider(scaleValueProvider, keypath: dotKeyPath)
        let ellipseKeyPath = AnimationKeypath(keypath: "C*.Ellipse 1.Scale")
        animationView.setValueProvider(scaleValueProvider, keypath: ellipseKeyPath)

        
        // Play the animation
        animationView?.play()
    }

    // Button action to open new view 'DownloadViewController'
    @IBAction func openDownload(_ sender: Any) {
        let viewController = DownloadViewController(
            nibName: "DownloadViewController", bundle: nil
        )
        present(viewController, animated: true)
    }
    
}

