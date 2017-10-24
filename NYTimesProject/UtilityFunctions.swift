//
//  UtilityFunctions.swift
//  NYTimesProject
//
//  Created by JonLu on 10/24/17.
//  Copyright © 2017 JonLu. All rights reserved.
//

import Foundation
import PCLBlurEffectAlert


struct UtilityFunctions {
    
    static func showAlert(_ alertMessage: String) {
        
        let alert = PCLBlurEffectAlertController(title: "ERROR", message: alertMessage, effect: UIBlurEffect(style: .regular), style: .alert)
        alert.configure(cornerRadius: 10)
        let cancelButton = PCLBlurEffectAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        
        alert.show()
    }
}
