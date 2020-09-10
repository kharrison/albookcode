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

final class RootViewController: UIViewController {
    private let sunView = UIImageView(named: "Sun", backgroundColor: .orange)
    private let snowView = UIImageView(named: "Snow", backgroundColor: .blue)

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This label should be below the tallest of the two images"
        label.font = UIFont.systemFont(ofSize: 32.0)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(sunView)
        view.addSubview(snowView)
        view.addSubview(captionLabel)

        let margins = view.layoutMarginsGuide
        let captionTopConstraint = captionLabel.topAnchor.constraint(equalTo: margins.topAnchor)
        captionTopConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            sunView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            sunView.topAnchor.constraint(equalTo: margins.topAnchor),

            snowView.topAnchor.constraint(equalTo: margins.topAnchor),
            snowView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            captionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            captionLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: sunView.bottomAnchor, multiplier: 1.0),
            captionLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: snowView.bottomAnchor, multiplier: 1.0),

            captionTopConstraint
            ])
    }
}

private extension UIImageView {
    convenience init(named name: String, backgroundColor: UIColor) {
        self.init(image: UIImage(named: name))
        self.backgroundColor = backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
