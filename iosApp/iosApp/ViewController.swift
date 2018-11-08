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
            do {
                let result = try CommonKt.getCompletedOrThrow(deferred)
                print("deferred completed: \(String(describing: result))")
                self.label.text = "\(result)"
                
            }catch {
                print("ERRRORRORORORORO \(error)")
                self.label.text = "error"
            }
            
            return KotlinUnit()
        })
                    
    }
    
}

public class UI: Kotlinx_coroutines_core_nativeCoroutineDispatcher {
    override public func dispatch(context: KotlinCoroutineContext, block: Kotlinx_coroutines_core_nativeRunnable) {
        DispatchQueue.main.async {
            block.run()
        }
    }
}
