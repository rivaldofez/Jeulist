//
//  Debouncer.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation

class Debouncer: NSObject {
    var callback: () -> Void
    var delay: Double
    weak var timer: Timer?

    init(delay: Double, callback: @escaping () -> Void) {
        self.delay = delay
        self.callback = callback
    }

    func fire() {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(toCallback), userInfo: nil, repeats: false)
        timer = nextTimer
    }

    @objc func toCallback() {
        callback()
    }
}
