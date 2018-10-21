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

final class BookViewController: UIViewController {

    private let padding: CGFloat = 20.0

    var book: Book? {
        didSet {
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            textView.text = book?.text
        }
    }

    private let titleLabel = UILabel.makeLabel(style: .title1)
    private let authorLabel = UILabel.makeLabel(style: .headline)
    private let textView = UITextView.makeTextView(style: .body)

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, textView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        view.addSubview(stackView)

        let readableGuide = view.readableContentGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: readableGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: readableGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: readableGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: readableGuide.bottomAnchor)
            ])
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.addSubview(scrollView)

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentGuide.topAnchor.constraint(equalTo: containerView.topAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            contentGuide.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

            frameGuide.widthAnchor.constraint(equalTo: contentGuide.widthAnchor)
            ])
    }
}
