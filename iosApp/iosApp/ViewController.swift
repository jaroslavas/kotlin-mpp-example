//
//  ViewController.swift
//  iosApp
//
//  Created by jetbrains on 12/04/2018.
//  Copyright © 2018 JetBrains. All rights reserved.
//

import UIKit
import greeting

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let product = Factory().create(config: ["user": "JetBrains"])
        label.text = product.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var label: UILabel!
    
    @IBAction func buttonPressed(){
        
        let greeting = Greeting()
        let deferred = greeting.anotherGreetingAsync(context: UI())
        deferred.invokeOnCompletion(handler: { _ in
            print("deferred completed: \(String(describing: deferred.getCompleted()))")
            self.label.text = "\(String(describing: deferred.getCompleted()))"            
            return KotlinUnit()
        })
        deferred.invokeOnCompletion(onCancelling: true, invokeImmediately: true, handler: {error in
            guard let error = error else {return KotlinUnit()}
            print("deferred error: \(String(describing: error))")
            self.label.text = "Error: \(String(describing: error))"
            return KotlinUnit()
        })
        label.text = "Please wait..."
    }
    
}

public class UI: Kotlinx_coroutines_core_nativeCoroutineDispatcher {
    override public func dispatch(context: KotlinCoroutineContext, block: Kotlinx_coroutines_core_nativeRunnable) {
        DispatchQueue.main.async {
            block.run()
        }
    }
}
