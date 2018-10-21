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
        static let labelFontSize: CGFloat = 24.0
        static let buttonFontSize: CGFloat = 18.0
        static let spacing: CGFloat = 8.0
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Engine Power", comment: "Engine Power")
        label.font = UIFont.systemFont(ofSize: ViewMetrics.labelFontSize)
        label.textAlignment = .center
        return label
    }()

    private let lowButton: UIButton = {
        let title = NSLocalizedString("Low", comment: "Low")
        let button = UIButton.makeButton(title: title, color: .red, fontSize: ViewMetrics.buttonFontSize)
        return button
    }()

    private let mediumButton: UIButton = {
        let title = NSLocalizedString("Medium", comment: "Medium")
        let button = UIButton.makeButton(title: title, color: .yellow, fontSize: ViewMetrics.buttonFontSize)
        return button
    }()

    private let highButton: UIButton = {
        let title = NSLocalizedString("High", comment: "High")
        let button = UIButton.makeButton(title: title, color: .green, fontSize: ViewMetrics.buttonFontSize)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, lowButton, mediumButton, highButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = ViewMetrics.spacing
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
    }
}

private extension UIButton {
    static func makeButton(title: String, color: UIColor, fontSize: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = color
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return button
    }
}
