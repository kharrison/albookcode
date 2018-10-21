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

    private lazy var cancelButton: UIButton = {
        let title = NSLocalizedString("Cancel", comment: "Cancel button")
        let button = UIButton.customButton(title: title, titleColor: .white, tintColor: .red, background: UIImage(named: "buttonTemplate"))
        button.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var okButton: UIButton = {
        let title = NSLocalizedString("OK", comment: "OK buton")
        let button = UIButton.customButton(title: title, titleColor: .white, tintColor: .green, background: UIImage(named: "buttonTemplate"))
        button.addTarget(self, action: #selector(okAction(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(cancelButton)
        view.addSubview(okButton)

        let leadingGuide = UILayoutGuide()
        let middleGuide = UILayoutGuide()
        let trailingGuide = UILayoutGuide()

        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)

        NSLayoutConstraint.activate([

            view.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor),
            leadingGuide.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor),

            cancelButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor),
            middleGuide.trailingAnchor.constraint(equalTo: okButton.leadingAnchor),

            okButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor),
            trailingGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            cancelButton.widthAnchor.constraint(equalTo: okButton.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor),
            leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor),

            cancelButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            okButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
}

extension ViewController {
    @objc private func cancelAction(_ sender: UIButton) {
        print("Cancel")
    }

    @objc private func okAction(_ sender: UIButton) {
        print("OK")
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
