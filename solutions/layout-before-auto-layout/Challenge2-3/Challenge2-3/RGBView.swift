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

final class RGBView: UIView {

    var spacing: CGFloat = 20 {
        didSet {
            setNeedsLayout()
        }
    }

    private let redBar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private let greenBar: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    private let blueBar: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    private var barViews = [UIView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        barViews = [redBar, greenBar, blueBar]
        barViews.forEach { addSubview($0) }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let barCount = CGFloat(barViews.count)
        if barCount > 0 {
            let barHeight = (bounds.height - (spacing * (barCount - 1))) / barCount
            var y = 0 as CGFloat
            for view in barViews {
                view.frame = CGRect(x: 0, y: y, width: bounds.width, height: barHeight)
                y += barHeight + spacing
            }
        }
    }
}
