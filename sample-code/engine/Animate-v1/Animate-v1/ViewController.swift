//  Copyright © 2018 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private var centerConstraint: NSLayoutConstraint!

    private enum AnimationMetrics {
        static let offset: CGFloat = -200
        static let duration: TimeInterval = 1.0
        static let delay: TimeInterval = 1.0
        static let damping: CGFloat = 0.4
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        centerConstraint.constant = AnimationMetrics.offset
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton(withDuration: AnimationMetrics.duration, damping: AnimationMetrics.damping, delay: AnimationMetrics.delay)
    }

    private func animateButton(withDuration duration: TimeInterval, damping: CGFloat, delay: TimeInterval = 0) {
        centerConstraint.constant = 0.0
        let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: damping, animations: {
            self.view.layoutIfNeeded()
        })
        animator.startAnimation(afterDelay: delay)
    }
}
