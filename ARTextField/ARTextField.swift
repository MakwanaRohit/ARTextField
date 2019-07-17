//
//  ARTextField.swift
//  ARTextField
//
//  Created by Rohit Makwana on 17/07/19.
//  Copyright © 2019 Rohit Makwana. All rights reserved.
//

import Foundation
import UIKit

public class ARTextField: UITextField {

    // MARK:- IBInspectable Variables

    @IBInspectable public var underLineColor: UIColor = UIColor.black
    @IBInspectable public var placeHolderColor: UIColor = UIColor.black
    
    // MARK:- Declared Variables

    fileprivate var placeholderLabel: UILabel?
    fileprivate var underLineView: UIView?
    fileprivate var titlePlaceholder: String?
    
    public var placeholderLabelFont: UIFont = UIFont.systemFont(ofSize: 13.0) {
        
        didSet{
            self.placeholderLabel?.font = self.placeholderLabelFont
        }
    }

    
    // MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        delegate = self
    }

    // MARK:- Draw
    
    override public func draw(_ rect: CGRect) {
        
        self.addUnderLine()
        self.createPlaceholderLabel()
        
        self.clipsToBounds = false
        self.borderStyle   = .none
    }
    
    
    // MARK:- Common UI Methods

    // Add Under Line

    fileprivate func addUnderLine() {
        
        let underLine = UIView.init(frame: CGRect.zero)
        
        underLine.backgroundColor = self.underLineColor
        self.underLineView = underLine
        self.updateLineViewFrame(false)
        
        self.addSubview(underLine)
    }
    
    // Create Placeholder Label

    fileprivate func createPlaceholderLabel() {
        
        let origin      = self.frame.origin
        let label       = UILabel(frame: CGRect(x: origin.x, y: origin.y, width: self.frame.size.width, height: 16.0))
        label.center    = self.center
        label.text      = ""
        label.font      = self.placeholderLabelFont
        label.textColor = self.placeHolderColor
        
        if let superView = self.superview {
            superView.insertSubview(label, belowSubview: self)
        }
        
        self.placeholderLabel = label
    }
    
    // Update line frame
    
    private func updateLineViewFrame(_ isEditing: Bool) {
    
        self.underLineView?.frame = CGRect(x: 0, y: self.frame.size.height - (isEditing ? 1.5 : 1.0), width: self.frame.size.width, height: (isEditing ? 1.5 : 1.0))
    }
}

// MARK:-
extension ARTextField: UITextFieldDelegate {
    
    // MARK:- UITextFieldDelegate

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let placeholderLabel = self.placeholderLabel, self.text == "" {
            
            if placeholderLabel.alpha == 0 {
                placeholderLabel.alpha = 1
            }
            
            if self.placeholder == "" {
                self.titlePlaceholder = placeholderLabel.text
            } else {
                self.titlePlaceholder = self.placeholder
            }
            
            self.placeholder = ""
            
            let frame = placeholderLabel.frame
            UIView.animate(withDuration: 0.5, animations: {
                
                placeholderLabel.text      = self.titlePlaceholder
                placeholderLabel.font      = self.placeholderLabelFont
                placeholderLabel.textColor = self.placeHolderColor
                placeholderLabel.frame.origin.y = frame.origin.y - placeholderLabel.frame.size.height - (self.frame.size.height / 2 - frame.size.height / 2)
                
            }, completion: { (isComplete) in
                
                self.updateLineViewFrame(true)
            })
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let placeholderLabel = self.placeholderLabel, self.text == "" {
            let frame = placeholderLabel.frame
            
            UIView.animate(withDuration: 0.5, animations: {
                
                placeholderLabel.alpha = 1
                placeholderLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0.09803921569, alpha: 0.22)
                
                placeholderLabel.frame.origin.y = frame.origin.y + placeholderLabel.frame.size.height + (self.frame.size.height / 2 - frame.size.height / 2)
                if let pointSize = self.font?.pointSize {
                    placeholderLabel.font = UIFont.systemFont(ofSize: pointSize)
                }
            }, completion: { (isComplete) in
                self.placeholder = self.titlePlaceholder
                placeholderLabel.alpha = 0
                
                self.updateLineViewFrame(false)
            })
        }
    }
}
