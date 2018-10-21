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

    private lazy var deleteButton: UIButton = {
        let title = NSLocalizedString("Delete All", comment: "Delete button")
        let button = UIButton.customButton(title: title, titleColor: .white, tintColor: .red, background: UIImage(named: "buttonTemplate"))
        button.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var completeButton: UIButton = {
        let title = NSLocalizedString("Mark Complete", comment: "Mark Complete button")
        let button = UIButton.customButton(title: title, titleColor: .white, tintColor: .green, background: UIImage(named: "buttonTemplate"))
        button.addTarget(self, action: #selector(okAction(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private var initialSetupDone = false

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !initialSetupDone {
            activateConstraints(for: view.bounds.width)
            initialSetupDone = true
        }
    }

    private let leadingGuide = UILayoutGuide()
    private let middleGuide = UILayoutGuide()
    private let trailingGuide = UILayoutGuide()

    private lazy var commonConstraints: [NSLayoutConstraint] = {
        let marginGuide = view.layoutMarginsGuide
        return [
            deleteButton.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            deleteButton.widthAnchor.constraint(equalTo: completeButton.widthAnchor)
            ]
    }()

    private lazy var wideConstraints: [NSLayoutConstraint] = {
        let marginGuide = view.layoutMarginsGuide
        return [
            completeButton.topAnchor.constraint(equalTo: marginGuide.topAnchor),

            leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor),

            marginGuide.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor),
            leadingGuide.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor),
            middleGuide.trailingAnchor.constraint(equalTo: completeButton.leadingAnchor),
            completeButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor),
            trailingGuide.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ]
    }()

    private lazy var narrowConstraints: [NSLayoutConstraint] = {
        let marginGuide = view.layoutMarginsGuide
        return [
            deleteButton.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            completeButton.centerXAnchor.constraint(equalTo: marginGuide.centerXAnchor),
            completeButton.topAnchor.constraint(equalToSystemSpacingBelow: deleteButton.bottomAnchor, multiplier: 2.0)
        ]
    }()

    private enum ViewMetrics {
        static let margin: CGFloat = 20.0
        static let narrowLayoutLimit: CGFloat = 500.0
    }

    private func setupView() {
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.margin, leading: ViewMetrics.margin, bottom: ViewMetrics.margin, trailing: ViewMetrics.margin)
        view.addSubview(deleteButton)
        view.addSubview(completeButton)

        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)

        NSLayoutConstraint.activate(commonConstraints)
    }

    private func activateConstraints(for width: CGFloat) {
        if width > ViewMetrics.narrowLayoutLimit {
            NSLayoutConstraint.deactivate(narrowConstraints)
            NSLayoutConstraint.activate(wideConstraints)
        } else {
            NSLayoutConstraint.deactivate(wideConstraints)
            NSLayoutConstraint.activate(narrowConstraints)
        }
    }
}

extension ViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if size != view.bounds.size {
            activateConstraints(for: size.width)
        }
    }
}

extension ViewController {
    @objc private func deleteAction(_ sender: UIButton) {
        print("Delete")
    }

    @objc private func okAction(_ sender: UIButton) {
        print("Mark complete")
    }
}

extension UIButton {
    static func customButton(title: String, titleColor: UIColor, tintColor: UIColor, background: UIImage?) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30.0)
        button.setBackgroundImage(background, for: .normal)
        button.tintColor = tintColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }
}
