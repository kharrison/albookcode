//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2018 Keith Harrison. All rights reserved.
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

public extension UIImageView {

    /**
     A convenience initializer to create a UIImageView with an image that has the specified edge insets. The UIImage is created from the named file with the specified edge insets.
     
     - Note: The image view is created with the `translatedAutoresizingMaskIntoConstraints` flag set to false ready for use with a constraints based layout.
     
     - Parameter named: A String which should match the name of a valid image file in the application bundle or asset
     catalog.
     - Parameter top: The inset at the top of an object.
     - Parameter left: The inset on the left of an object.
     - Parameter bottom: The inset on the bottom of an object.
     - Parameter right: The inset on the right of an object.
     
     - Returns: The newly created UIImageView.
     */
    
    public convenience init(named name: String, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        let insets = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        let originalImage = UIImage(named: name)
        let insetImage = originalImage?.withAlignmentRectInsets(insets)
        self.init(image: insetImage)
    }
}
