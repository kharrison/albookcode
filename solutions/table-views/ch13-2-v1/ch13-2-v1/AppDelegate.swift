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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private let book = Book(title: "Great Expectations",
                            author: "Charles Dickens",
                            text: [
                                "Chapter I",
                                """
        My father's family name being Pirrip, and my \
        Christian name Philip, my infant tongue could \
        make of both names nothing longer or more \
        explicit than Pip.
        """,
                                """
        So, I called myself Pip, and came to be called Pip.
        """,
                                """
        I give Pirrip as my father's family name, on the \
        authority of his tombstone and my sister,--Mrs. \
        Joe Gargery, who married the blacksmith.
        """,
                                """
        As I never saw my father or my mother, and never \
        saw any likeness of either of them (for their \
        days were long before the days of photographs), \
        my first fancies regarding what they were like \
        were unreasonably derived from their tombstones.
        """,
                                """
        The shape of the letters on my father's, gave me \
        an odd idea that he was a square, stout, dark man, \
        with curly black hair.
        """
        ])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let navigationController = window?.rootViewController as? UINavigationController,
            let bookTableViewController = navigationController.topViewController as? BookTableViewController {
            bookTableViewController.book = book
        }
        return true
    }
}
