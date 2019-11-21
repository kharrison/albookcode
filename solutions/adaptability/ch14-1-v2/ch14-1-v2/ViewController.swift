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
    private enum ViewMetrics {
        static let spacing: CGFloat = 32.0
        static let fontSize: CGFloat = 40.0
    }

    private let previewButton: UIButton = {
        let title = NSLocalizedString("Preview", comment: "Preview button title")
        let button = UIButton.customButton(title: title, color: .yellow, fontSize: ViewMetrics.fontSize)
        button.addTarget(self, action: #selector(previewAction(_:)), for: .touchUpInside)
        return button
    }()

    private let buyButton: UIButton = {
        let title = NSLocalizedString("Buy", comment: "Buy button title")
        let button = UIButton.customButton(title: title, color: .green, fontSize: ViewMetrics.fontSize)
        button.addTarget(self, action: #selector(buyAction(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previewButton, buyButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = ViewMetrics.spacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView(for: traitCollection)
    }

    private func setupView() {
        view.backgroundColor = .lightGray
        view.addSubview(stackView)
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            margin.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            margin.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            margin.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
        ])
    }
}

extension ViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.horizontalSizeClass != traitCollection.horizontalSizeClass {
            configureView(for: traitCollection)
        }
    }

    private func configureView(for traitCollection: UITraitCollection) {
        if traitCollection.horizontalSizeClass == .regular {
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
        } else {
            stackView.axis = .vertical
            stackView.distribution = .fill
        }
    }
}

extension ViewController {
    @objc private func previewAction(_ sender: UIButton) {
        print("preview")
    }

    @objc private func buyAction(_ sender: UIButton) {
        print("buy")
    }
}

private extension UIButton {
    static func customButton(title: String, color: UIColor, fontSize: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return button
    }
}
