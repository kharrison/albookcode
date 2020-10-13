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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let bookTitle = "The Wonderful Wizard of Oz"
        let author = "by L. Frank Baum"
        let chapterTitle = "1. The Cyclone"
        let text = """
        Dorothy lived in the midst of the great Kansas prairies, with \
        Uncle Henry, who was a farmer, and Aunt Em, who was the \
        farmer's wife. Their house was small, for the lumber to build \
        it had to be carried by wagon many miles. There were four \
        walls, a floor and a roof, which made one room; and this room \
        contained a rusty looking cookstove, a cupboard for the \
        dishes, a table, three or four chairs, and the beds. Uncle \
        Henry and Aunt Em had a big bed in one corner, and Dorothy a \
        little bed in another corner. There was no garret at all, and \
        no cellar--except a small hole dug in the ground, called a \
        cyclone cellar, where the family could go in case one of those \
        great whirlwinds arose, mighty enough to crush any building in \
        its path. It was reached by a trap door in the middle of the \
        floor, from which a ladder led down into the small, dark hole.

        When Dorothy stood in the doorway and looked around, she could \
        see nothing but the great gray prairie on every side. Not a \
        tree nor a house broke the broad sweep of flat country that \
        reached to the edge of the sky in all directions. The sun had \
        baked the plowed land into a gray mass, with little cracks \
        running through it. Even the grass was not green, for the sun \
        had burned the tops of the long blades until they were the \
        same gray color to be seen everywhere. Once the house had been \
        painted, but the sun blistered the paint and the rains washed \
        it away, and now the house was as dull and gray as everything \
        else.
        """
        let chapter = Chapter(bookTitle: bookTitle, author: author, chapterTitle: chapterTitle, text: text)

        if let navigationController = window?.rootViewController as? UINavigationController,
            let bookViewController = navigationController.topViewController as? BookViewController
        {
            bookViewController.chapter = chapter
        }

        return true
    }
}
