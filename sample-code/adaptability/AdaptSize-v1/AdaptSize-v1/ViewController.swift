//  Copyright © 2018-2026 Keith Harrison. All rights reserved.
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
    @IBOutlet private var stackView: UIStackView!

//    private var initialSetupDone = false
//
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        if !initialSetupDone {
//            configureView(for: view.bounds.size)
//            initialSetupDone = true
//        }
//    }

    
    // viewIsAppearing was added in iOS 17, but is
    // back deployable to iOS 13. It's a great place
    // for configuring the view as it's called only
    // once after the view is added to the view hierarchy
    // so we can rely on the size being correct
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        configureView(for: view.bounds.size)
    }
    
    private func configureView(for size: CGSize) {
        if size.width > size.height {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
}

extension ViewController {
    private enum AnimationMetrics {
        static let duration: TimeInterval = 0.3
        static let transformScale: CGFloat = 1.25
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // Device can rotate 180 degrees.
        if size != view.bounds.size {
            configureView(for: size)
            animateStack(with: coordinator)
        }
    }

    private func animateStack(with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            self.stackView.transform = CGAffineTransform(scaleX: AnimationMetrics.transformScale, y: AnimationMetrics.transformScale)
        }, completion: { _ in
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: AnimationMetrics.duration, delay: 0, options: [], animations: {
                self.stackView.transform = .identity
            })
        })
    }
}

#if DEBUG
@available(iOS 17, *)
#Preview("Portrait", traits: .portrait) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc =
    storyboard.instantiateViewController(withIdentifier:
    "ViewController") as! ViewController
    return vc
}

@available(iOS 17, *)
#Preview("Landscape", traits: .landscapeLeft) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc =
    storyboard.instantiateViewController(withIdentifier:
    "ViewController") as! ViewController
    return vc
}
#endif
