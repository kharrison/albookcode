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

protocol PanicViewDelegate: AnyObject {
    func panic(_ sender: PanicView)
    func noPanic(_ sender: PanicView)
}

final class PanicView: UIView {

    weak var delegate: PanicViewDelegate?

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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noPanicButton, panicButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = ViewMetrics.spacing
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

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

        switch stackView.axis {
        case .horizontal:
            // If we do not have the space to show the buttons
            // horizontally switch to vertical layout
            if minHorizontalWidth > marginWidth {
                stackView.axis = .vertical
            }
        case .vertical:
            // If there is space to show the buttons switch
            // to horizontal layout
            if minHorizontalWidth <= marginWidth {
                stackView.axis = .horizontal
            }
        }
    }

    private func setupView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            layoutMarginsGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            layoutMarginsGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
            ])
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
