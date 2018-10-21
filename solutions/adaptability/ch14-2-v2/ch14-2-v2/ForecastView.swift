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

final class ForecastView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel.makeLabel(forTextStyle: .title1)
        label.textAlignment = .center
        return label
    }()

    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        return view
    }()

    let summaryLabel: UILabel = {
        return UILabel.makeLabel(forTextStyle: .body)
    }()

    private lazy var commonConstraints: [NSLayoutConstraint] = {
        let margin = readableContentGuide
        return [
            titleLabel.topAnchor.constraint(equalTo: margin.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
        ]
    }()

    private lazy var regularConstraints: [NSLayoutConstraint] = {
        let margin = readableContentGuide
        return [
            imageView.centerXAnchor.constraint(equalTo: margin.centerXAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),

            titleLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),

            summaryLabel.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            summaryLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1.0),
            summaryLabel.bottomAnchor.constraint(equalTo: margin.bottomAnchor)
        ]
    }()

    private lazy var compactConstraints: [NSLayoutConstraint] = {
        let margin = readableContentGuide
        let heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.priority = .defaultLow

        return [
            imageView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: margin.topAnchor),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: margin.bottomAnchor),

            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1.0),
            summaryLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: imageView.trailingAnchor, multiplier: 1.0),

            summaryLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0),
            summaryLabel.bottomAnchor.constraint(lessThanOrEqualTo: margin.bottomAnchor),

            heightConstraint
        ]
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(summaryLabel)
        addSubview(imageView)
        NSLayoutConstraint.activate(commonConstraints)
    }
}

extension ForecastView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.verticalSizeClass != traitCollection.verticalSizeClass {
            if traitCollection.verticalSizeClass == .compact {
                NSLayoutConstraint.deactivate(regularConstraints)
                NSLayoutConstraint.activate(compactConstraints)
            } else {
                NSLayoutConstraint.deactivate(compactConstraints)
                NSLayoutConstraint.activate(regularConstraints)
            }
        }
    }
}
