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

final class ProfileViewController: UIViewController {

    private enum ViewMetrics {
        static let margin: CGFloat = 20.0
        static let nameFontSize: CGFloat = 18.0
        static let bioFontSize: CGFloat = 17.0
    }

    var profile: Profile? {
        didSet {
            configureView()
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: ViewMetrics.nameFontSize)
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: ViewMetrics.bioFontSize)
        label.numberOfLines = 0
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .top
        imageView.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return imageView
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()

    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageView, labelStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView()
    }

    private func setupView() {
        view.backgroundColor = UIColor(named: "sky")
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.margin, leading: ViewMetrics.margin, bottom: ViewMetrics.margin, trailing: ViewMetrics.margin)
        view.addSubview(profileStackView)

        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            profileStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            profileStackView.topAnchor.constraint(equalTo: margin.topAnchor),
            profileStackView.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
            ])
    }

    private func configureView() {
        if let image = profile?.avatar {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(named: "placeholder")
        }

        title = profile?.name
        nameLabel.text = profile?.name
        bioLabel.text = profile?.bio
    }
}
