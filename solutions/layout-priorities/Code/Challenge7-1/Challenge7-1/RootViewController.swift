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
    private let fontSize: CGFloat = 24.0
    private let minimumWidth: CGFloat = 160.0

    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .yellow
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }()

    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .purple
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        authorLabel.text = "William Shakespeare"
        quoteLabel.text = "To be, or not to be, that is the question"
    }

    private func setupView() {
        view.addSubview(authorLabel)
        view.addSubview(quoteLabel)

        let optionalWidthConstraint = quoteLabel.widthAnchor.constraint(equalTo: authorLabel.widthAnchor, multiplier: 2.0)
        optionalWidthConstraint.priority = .defaultHigh

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            authorLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            quoteLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            quoteLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            quoteLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: authorLabel.trailingAnchor, multiplier: 1.0),
            authorLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: minimumWidth),
            optionalWidthConstraint
            ])
    }
}
