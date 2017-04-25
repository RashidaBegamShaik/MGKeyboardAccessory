//
//  UITextField+KeyboardAccessory.swift
//  MGKeyboardAccessory
//
//  Created by limeng on 01/22/2017.
//  Copyright (c) 2017 fczm.pw. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public extension UITextField {
    
    func setupKeyboardAccessory(_ strings: [String], barStyle: UIBarStyle) {
        let buttonColor = (barStyle == .default) ? UIColor.darkGray : UIColor.white
        
        let topView: UIToolbar = {
            let toolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
            toolbar.barStyle = barStyle;
            let clearButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                  target: self,
                                                  action: #selector(clearTextFeild))
            clearButtonItem.tintColor = buttonColor
            let spaceButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                  target: self,
                                                  action: nil)
            let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                 target: self,
                                                 action: #selector(editFinish))
            doneButtonItem.width = 150;
            doneButtonItem.tintColor = buttonColor
            
            let items = [clearButtonItem,
                         spaceButtonItem,
                         createStringBarButtonItem(strings: strings,
                                                   color:  buttonColor,
                                                   action: #selector(addText(_:)),
                                                   height: 26),
                         spaceButtonItem,
                         doneButtonItem]
            toolbar.setItems(items, animated: false)
            
            return toolbar
        }()
        
        self.inputAccessoryView = topView
    }
    
    func createStringBarButtonItem(strings: [String], color: UIColor, action: Selector, height: CGFloat) -> UIBarButtonItem {
        let buttonsView = UIView()
        var x: CGFloat = 0
        var width: CGFloat = 0
        for string in strings {
            let stringButton: UIButton = {
                let button = UIButton(type: .custom)
                button.setTitle(string, for: .normal)
                width = button.sizeThatFits(CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: height)).width
                if width > height * 1.2 {
                    width += height / 4;
                }
                button.frame = CGRect(x: x, y: 0, width: width, height: height)
                button.layer.cornerRadius = 5
                button.layer.borderWidth = 1
                button.layer.borderColor = color.cgColor
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
                button.addTarget(target, action: action, for: .touchUpInside)
                return button
            }()
            buttonsView.addSubview(stringButton)
            x = x + 2 + width
        }
        buttonsView.frame = CGRect(x: 0, y: 0, width: x - 2, height: height)
        let characterButtonItem = UIBarButtonItem(customView: buttonsView)
        return characterButtonItem
    }
    
    func addText(_ sender: UIButton) {
        self.insertText((sender.titleLabel?.text)!)
    }
    
    func editFinish() {
        if self.isFirstResponder {
            self.resignFirstResponder()
        }
    }
    
    func clearTextFeild() {
        if self.isFirstResponder {
            self.text = ""
        }
    }
    
}
