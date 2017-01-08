//
//  ScalingWallGen.swift
//  NimbleNinja
//
//  Created by Tevin Scott on 1/6/17.
//  Copyright © 2017 Tevin Scott. All rights reserved.
//

import Foundation
class ScalingWallGen : TSWallGen {
    var rampUpTimer: Timer?
    
    
    
    func startWallGen(_ seconds : TimeInterval){
        rampUpTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(ScalingWallGen.startGeneratingWallEvery), userInfo: nil, repeats: true)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
