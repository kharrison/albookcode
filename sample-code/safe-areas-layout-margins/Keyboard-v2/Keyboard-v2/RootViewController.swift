//  Copyright © 2021 Keith Harrison. All rights reserved.
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
    private lazy var toolbar: Toolbar = {
        let toolbar = Toolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(toolbar)
        view.keyboardLayoutGuide.followsUndockedKeyboard = true
        
        let awayFromTop = toolbar.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        awayFromTop.identifier = "KB-awayFromTop"
        view.keyboardLayoutGuide.setConstraints([awayFromTop], activeWhenAwayFrom: .top)
        
        let nearTop = toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        nearTop.identifier = "KB-nearTop"
        view.keyboardLayoutGuide.setConstraints([nearTop], activeWhenNearEdge: .top)
        
        let inMiddle = toolbar.centerXAnchor.constraint(equalTo: view.keyboardLayoutGuide.centerXAnchor)
        inMiddle.identifier = "KB-inMiddle"
        view.keyboardLayoutGuide.setConstraints([inMiddle], activeWhenAwayFrom: [.leading, .trailing])
        
        let nearLeading = toolbar.leadingAnchor.constraint(equalTo: view.keyboardLayoutGuide.leadingAnchor)
        nearLeading.identifier = "KB-nearLeading"
        view.keyboardLayoutGuide.setConstraints([nearLeading], activeWhenNearEdge: .leading)
        
        let nearTrailing = toolbar.trailingAnchor.constraint(equalTo: view.keyboardLayoutGuide.trailingAnchor)
        nearTrailing.identifier = "KB-nearTrailing"
        view.keyboardLayoutGuide.setConstraints([nearTrailing], activeWhenNearEdge: .trailing)
    }
}
