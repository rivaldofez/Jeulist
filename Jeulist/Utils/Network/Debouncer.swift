//
//  Debouncer.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation

import Foundation

class Debouncer: NSObject {
    private var callback: () -> Void
    private var delay: Double
    private weak var timer: Timer?
    
    init(delay: Double, callback: @escaping () -> Void) {
        self.delay = delay
        self.callback = callback
    }
    
    func call() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(
            timeInterval: delay,
            target: self,
            selector: #selector(fire),
            userInfo: nil,
            repeats: false
        )
        timer = nextTimer
    }
    
    @objc private func fire() {
        callback()
    }
}
