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
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var chapterLabel: UILabel!
    @IBOutlet private var textView: UITextView!

    var chapter: Chapter? {
        didSet {
            configureView()
        }
    }

    var fontName = "Roboto" {
        didSet {
            scaledFont = ScaledFont(fontName: fontName)
            configureFont()
        }
    }

    private lazy var scaledFont: ScaledFont = {
        ScaledFont(fontName: fontName)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureFont()

        // Uncomment to print all available font names
        //        let families = UIFont.familyNames
        //        families.sorted().forEach {
        //            print("\($0)")
        //            let names = UIFont.fontNames(forFamilyName: $0)
        //            print(names)
        //        }
    }

    private func configureView() {
        titleLabel?.text = chapter?.bookTitle
        authorLabel?.text = chapter?.author
        chapterLabel?.text = chapter?.chapterTitle
        textView?.text = chapter?.text
    }

    private func configureFont() {
        titleLabel?.font = scaledFont.font(forTextStyle: .title1)
        authorLabel?.font = scaledFont.font(forTextStyle: .subheadline)
        chapterLabel?.font = scaledFont.font(forTextStyle: .headline)
        textView?.font = scaledFont.font(forTextStyle: .body)
    }
}
