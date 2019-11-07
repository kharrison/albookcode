//  Created by Keith Harrison https://useyourloaf.com
//  Copyright © 2019 Keith Harrison. All rights reserved.
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

@objc protocol PanicViewDelegate: AnyObject {
    func panic(_ sender: PanicView)
    func noPanic(_ sender: PanicView)
}

@IBDesignable
final class PanicView: UIView {
    @IBOutlet weak var delegate: PanicViewDelegate?

    private enum ViewMetrics {
        static let fontSize: CGFloat = 24.0
        static let spacing: CGFloat = 16.0
    }

    private lazy var panicButton: UIButton = {
        let title = NSLocalizedString("Panic", comment: "Panic")
        let button = UIButton.makeButton(title: title, color: .red, fontSize: ViewMetrics.fontSize)
        button.addTarget(self, action: #selector(panic(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var noPanicButton: UIButton = {
        let title = NSLocalizedString("Don't Panic", comment: "Don't Panic")
        let button = UIButton.makeButton(title: title, color: .green, fontSize: ViewMetrics.fontSize)
        button.addTarget(self, action: #selector(noPanic(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var horizontalConstraints: [NSLayoutConstraint] = {
        let constraints = [
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: noPanicButton.bottomAnchor),
            panicButton.leadingAnchor.constraint(equalTo: noPanicButton.trailingAnchor, constant: ViewMetrics.spacing),
            layoutMarginsGuide.topAnchor.constraint(equalTo: panicButton.topAnchor)
        ]
        return constraints
    }()

    private lazy var verticalConstraints: [NSLayoutConstraint] = {
        let constraints = [
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: noPanicButton.trailingAnchor),
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: panicButton.leadingAnchor),
            panicButton.topAnchor.constraint(equalTo: noPanicButton.bottomAnchor, constant: ViewMetrics.spacing)
        ]
        return constraints
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private var horizontal = true

    override func layoutSubviews() {
        super.layoutSubviews()

        // The minimum size of our buttons should be the
        // largest intrinsic content size of any button
        let minButtonWidth = max(noPanicButton.intrinsicContentSize.width, panicButton.intrinsicContentSize.width)

        // The minimum width we need to show both buttons
        // horizontally including the spacing
        let minHorizontalWidth = minButtonWidth * 2 + ViewMetrics.spacing

        // The space between the margins
        let marginWidth = layoutMarginsGuide.layoutFrame.width

        if horizontal {
            if minHorizontalWidth > marginWidth {
                horizontal = false
                NSLayoutConstraint.deactivate(horizontalConstraints)
                NSLayoutConstraint.activate(verticalConstraints)
            }
        } else {
            if minHorizontalWidth <= marginWidth {
                horizontal = true
                NSLayoutConstraint.deactivate(verticalConstraints)
                NSLayoutConstraint.activate(horizontalConstraints)
            }
        }
    }

    private func setupView() {
        addSubview(noPanicButton)
        addSubview(panicButton)

        let baseConstraints = [
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: noPanicButton.leadingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: noPanicButton.topAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: panicButton.trailingAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: panicButton.bottomAnchor),
            noPanicButton.widthAnchor.constraint(equalTo: panicButton.widthAnchor)
        ]

        NSLayoutConstraint.activate(baseConstraints + horizontalConstraints)
        horizontal = true
    }

    @objc private func panic(_ sender: UIButton) {
        delegate?.panic(self)
    }

    @objc private func noPanic(_ sender: UIButton) {
        delegate?.noPanic(self)
    }
}

extension UIButton {
    static func makeButton(title: String, color: UIColor, fontSize: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        button.backgroundColor = color
        return button
    }
}
