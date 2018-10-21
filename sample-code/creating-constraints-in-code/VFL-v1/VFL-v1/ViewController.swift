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

    private let redView = UIView.makeView(color: .red)
    private let greenView = UIView.makeView(color: .green)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(redView)
        view.addSubview(greenView)

        /*
         Build a dictionary of the views we will use when creating
         constraints. The dictionary keys are the strings we use
         in the VFL format string when creating the constraints.
         */
        let views = [
            "redView" : redView,
            "greenView" : greenView
        ]

        /*
         Build a dictionary of any magic numbers we use in the visual
         format string.
         */
        let metrics = [
            "padding" : 50.0,
            "spacing" : 25.0
        ]

        /*
         Create the horizontal constraints that pin the red and green view leading and
         trailing edges to the root view.

         + The `|` represents the edge of the super view.
         */
        let hRedConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[redView]-(padding)-|", options: [], metrics: metrics, views: views)

        let hGreenConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(padding)-[greenView]-(padding)-|", options: [], metrics: metrics, views: views)

        /*
         Create the vertical constraints
         */
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(padding)-[redView(==greenView)]-(spacing)-[greenView]-(padding)-|", options: [], metrics: metrics, views: views)

        let constraints = hRedConstraints + hGreenConstraints + vConstraints
        NSLayoutConstraint.activate(constraints)
    }
}

private extension UIView {
    static func makeView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}
