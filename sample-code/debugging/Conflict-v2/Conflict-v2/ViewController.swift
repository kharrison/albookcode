//  Copyright © 2018-2022 Keith Harrison. All rights reserved.
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
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32.0)
        button.addTarget(self, action: #selector(go(_:)), for: .touchUpInside)
        return button
    }()

    private let greenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    private let redView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    private lazy var redConstraints: [NSLayoutConstraint] = {
        let margins = view.layoutMarginsGuide
        return [
            greenView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.25),
            redView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0)
        ]
    }()

    private lazy var greenConstraints: [NSLayoutConstraint] = {
        let margins = view.layoutMarginsGuide
        return [
            greenView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0),
            redView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.25)
        ]
    }()

    private lazy var commonConstraints: [NSLayoutConstraint] = {
        let margins = view.layoutMarginsGuide
        return [
            button.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            button.topAnchor.constraint(equalToSystemSpacingBelow: margins.topAnchor, multiplier: 2.0),

            greenView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            greenView.topAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 2.0),
            greenView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2),

            redView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            redView.topAnchor.constraint(equalToSystemSpacingBelow: greenView.bottomAnchor, multiplier: 2.0),
            redView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.2)
            ]
    }()

    @objc private func go(_ sender: UIButton) {
        // Forgetting to deactivate first creates a conflict
        // NSLayoutConstraint.deactivate(greenConstraints)
        NSLayoutConstraint.activate(redConstraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(button)
        view.addSubview(greenView)
        view.addSubview(redView)
        NSLayoutConstraint.activate(commonConstraints + greenConstraints)
    }
}
