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
    private enum ViewMetrics {
        static let codeFontSize: CGFloat = 40
        static let codeSpacing: CGFloat = 16
        static let codeBackgroundColor: UIColor = .yellow
        static let codeColor: UIColor = .black
        static let verticalSpacing: CGFloat = 16
        static let margin: CGFloat = 16
        static let backgroundColor: UIColor = .purple
        static let coverColor: UIColor = .yellow
        static let animationDuration: TimeInterval = 0.25
    }

    private let code1 = UILabel.makeLabel("1A", fontSize: ViewMetrics.codeFontSize, textColor: ViewMetrics.codeColor, backgroundColor: ViewMetrics.codeBackgroundColor)
    private let code2 = UILabel.makeLabel("2BX", fontSize: ViewMetrics.codeFontSize, textColor: ViewMetrics.codeColor, backgroundColor: ViewMetrics.codeBackgroundColor)
    private let code3 = UILabel.makeLabel("3Z", fontSize: ViewMetrics.codeFontSize, textColor: ViewMetrics.codeColor, backgroundColor: ViewMetrics.codeBackgroundColor)

    private lazy var codeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [code1, code2, code3])
        stackView.distribution = .fillEqually
        stackView.spacing = ViewMetrics.codeSpacing
        return stackView
    }()

    private lazy var codeSwitch: UISwitch = {
        let codeSwitch = UISwitch()
        codeSwitch.addTarget(self, action: #selector(showCode(_:)), for: .valueChanged)
        return codeSwitch
    }()

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [codeSwitch, codeStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = ViewMetrics.verticalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.margin, leading: ViewMetrics.margin, bottom: ViewMetrics.margin, trailing: ViewMetrics.margin)
        return stackView
    }()

    private var coverView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCover()
    }

    private func setupView() {
        view.addSubview(rootStackView)
        title = NSLocalizedString("Show Code", comment: "Show Code")
        rootStackView.addBackground(color: ViewMetrics.backgroundColor)
        coverView = codeStackView.addForeground(color: ViewMetrics.coverColor)
        codeSwitch.isOn = false

        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func showCode(_ sender: UISwitch) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: ViewMetrics.animationDuration, delay: 0, options: [], animations: {
            self.configureCover()
        }, completion: nil)
    }

    private func configureCover() {
        coverView?.alpha = codeSwitch.isOn ? 0 : 1.0
    }
}

private extension UILabel {
    static func makeLabel(_ text: String, fontSize: CGFloat, textColor: UIColor, backgroundColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        return label
    }
}
