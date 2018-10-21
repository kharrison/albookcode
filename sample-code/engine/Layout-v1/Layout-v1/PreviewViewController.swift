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

final class PreviewViewController: UIViewController {

    private let itemCount = 10

    private lazy var previewPane: PreviewPane = {
        let view = PreviewPane()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(refresh(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        refreshRandomViews()
    }

    private func setupView() {
        view.backgroundColor = .yellow
        view.addSubview(refreshButton)
        view.addSubview(previewPane)

        let guide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            refreshButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            refreshButton.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),

            previewPane.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            previewPane.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            previewPane.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
            ])
    }

    @objc private func refresh(_ sender: UIButton) {
        refreshRandomViews()
    }

    private func refreshRandomViews() {
        var views = [UIView]()
        for count in 0..<itemCount {
            let view = UILabel()
            view.text = "\(count)"
            let size = CGFloat(arc4random_uniform(64)) + 64.0
            view.font = UIFont.systemFont(ofSize: size)
            view.backgroundColor = (count % 2 == 0) ? .red : .green
            views.append(view)
        }
        previewPane.show(views)
    }
}
