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

final class ActivityViewController: UIViewController {

    private enum ViewMetrics {
        static let labelFontSize: CGFloat = 56.0
        static let buttonFontSize: CGFloat = 32.0
        static let buttonInset: CGFloat = 10.0
        static let contentMargin: CGFloat = 8.0
    }

    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showInfo(_:)), for: .touchUpInside)
        return button
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: ViewMetrics.labelFontSize)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = NSLocalizedString("Get Ready!", comment: "")
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Skater"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        let title = NSLocalizedString("Start", comment: "")
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: ViewMetrics.buttonFontSize)
        button.contentEdgeInsets = UIEdgeInsets(top: ViewMetrics.buttonInset, left: 0.0, bottom: ViewMetrics.buttonInset, right: 0.0)
        return button
    }()

    private lazy var activityView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, imageView, button])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.contentMargin, leading: ViewMetrics.contentMargin, bottom: ViewMetrics.contentMargin, trailing: ViewMetrics.contentMargin)
        return stackView
    }()

    private lazy var scrollView: AdaptiveScrollView = {
        let scrollView = AdaptiveScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(activityView)
        scrollView.addSubview(infoButton)
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.tintColor = .black
        title = NSLocalizedString("Activity", comment: "")
        setupView()
    }

    private func setupView() {
        view.addSubview(scrollView)

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide
        let margin = scrollView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentGuide.leadingAnchor.constraint(equalTo: activityView.leadingAnchor),
            contentGuide.topAnchor.constraint(equalTo: activityView.topAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: activityView.trailingAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: activityView.bottomAnchor),

            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor),

            infoButton.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            infoButton.topAnchor.constraint(equalTo: margin.topAnchor)
            ])
    }
}


extension ActivityViewController {
    @objc private func showInfo(_ sender: UIButton) {
        print("Show Info")
    }
}
