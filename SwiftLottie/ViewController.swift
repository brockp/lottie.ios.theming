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
        animationView = .init(name: "penrose-triangle")
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
        
        // Create ColorValueProvider using Lottie's Color class
        let orange = Color(r: (251/255), g: (140/255), b: (0/255), a: 1)
        let orangeColorValueProvider = ColorValueProvider(orange)
        // Set color value provider to animation view
        let keyPath = AnimationKeypath(keypath: "**.Fill 1.Color")
        animationView.setValueProvider(orangeColorValueProvider, keypath: keyPath)
        
        
        // Scale up dots & ellipse
//        let scaleValueProvider = SizeValueProvider(CGSize(width: 200, height: 200))
//        let dotKeyPath = AnimationKeypath(keypath: "Dot*.Shape 1.Scale")
//        animationView.setValueProvider(scaleValueProvider, keypath: dotKeyPath)
//        let ellipseKeyPath = AnimationKeypath(keypath: "C*.Ellipse 1.Scale")
//        animationView.setValueProvider(scaleValueProvider, keypath: ellipseKeyPath)
        
        
        // Change dots opacity (range 0 ~ 100)
//        let opacityValueProvider = FloatValueProvider(CGFloat(50))
//        let dotOpacityKeyPath = AnimationKeypath(keypath: "Dot*.Shape 1.Opacity")
//        animationView.setValueProvider(opacityValueProvider, keypath: dotOpacityKeyPath)

        
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

