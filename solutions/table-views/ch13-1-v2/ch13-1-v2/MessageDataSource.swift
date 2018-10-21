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

final class MessageDataSource: NSObject {

    private let tableView: UITableView
    private let messages: [Message] = [
        Message(username: "Joe", text: "Hello World!"),
        Message(username: "Peter Piper", text: "Mr. Watson I presume"),
        Message(username: "Harry Housefield", text: "Once upon a time, in a land far far away"),
        Message(username: "Sir Roger Martin-Grayson III", text: "I cannot wait to see what happens next. I do hope they all lived happily ever after.")
    ]

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension MessageDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseIdentifier, for: indexPath)
        configure(cell: cell, indexPath: indexPath)
        return cell
    }

    private func configure(cell: UITableViewCell, indexPath: IndexPath) {
        if let cell = cell as? MessageCell {
            let message = messages[indexPath.row]
            cell.nameLabel.text = message.username
            cell.messageLabel.text = message.text
            cell.profileImageView = UIImageView(image: UIImage(named: "placeholder"))

            // Configure the preferred font as the automatic
            // support for content size changes is not available
            // for iOS 9.

            // If you are targetting iOS 10 or later this is not required.
            // Set adjustsFontForContentSizeCategory on the label instead.
            cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            cell.messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
        }
    }
}
