//
//  AZPicker.swift
//  AZViewer
//
//  Created by Ali Zahedi on 1/6/1396 AP.
//  Copyright © 1396 AP Ali Zahedi. All rights reserved.
//

import Foundation

public class AZPicker: AZPopupView{
    
    // MARK: Var
    var data: [[(AnyObject, String)]] = [[]] {
        didSet{
            self.pickerView.reloadAllComponents()
        }
    }
    
    var delegate: AZPickerViewDelegate?
    var pickerView: AZPickerView = AZPickerView()
    var font: UIFont!{
        didSet{
            self.pickerView.reloadAllComponents()
        }
    }
    var color: UIColor!{
        didSet{
            self.pickerView.reloadAllComponents()
        }
    }
    
    // private
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.defaultInit()
    }
    
    // MARK: Function
    fileprivate func defaultInit(){
        
        self.loader.parent(parent: self)
        
        for v in [pickerView] as [UIView] {
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
        
        self.preparePickerView()
        self.title = "عنوان اول"
        self.header.type = .success
        self.font = self.style.sectionPickerViewItemFont
        self.color = self.style.sectionPickerViewItemColor
    }
    
}

// Prepare
extension AZPicker{
    
    // pickerview
    fileprivate func preparePickerView(){
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.showsSelectionIndicator = true
        _ = self.pickerView.aZConstraints.parent(parent: self).top(to: self.header, toAttribute: .bottom).right().left().bottom()
    }
    
}

// pickerview
extension AZPicker: UIPickerViewDataSource{
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return self.data.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.data[component].count
    }
}

extension AZPicker: UIPickerViewDelegate{
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.delegate?.aZPickerView(didSelectRow: row, inComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        label?.font = self.font
        label?.textColor = self.color
        label?.textAlignment = .center
        label?.text = self.data[component][row].1
        return label!
    }
}
