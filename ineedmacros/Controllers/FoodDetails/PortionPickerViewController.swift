//  Created by Kacper Jagiello on 29/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class PortionPickerViewController: UIViewController {
    
    var valueReceiver: PortionModifierDelegate?
    var selectedModifier: Float = 1

    var multipliers: Array<Float> = {
        var array = [Float]()
        for multiplier in stride(from: 0.1, to: 10.1, by: 0.1) {
            array.append(Float(multiplier))
        }
        return array
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        
        let pickerView = UIPickerView()
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 0).isActive = true
        pickerView.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 0).isActive = true
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let defaultValue = multipliers.firstIndex(of: 1)
        pickerView.selectRow(defaultValue!, inComponent: 0, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc private func handleDone() {
        valueReceiver?.collect(value: selectedModifier)
        valueReceiver?.modifyPortion()
        dismiss(animated: true, completion: nil)
    }
}

extension PortionPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return multipliers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(multipliers[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedModifier = Float(multipliers[row])
        print(selectedModifier)
    }
}
