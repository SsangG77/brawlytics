//
//  HyperchargeDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation

//MARK: - DataSource
protocol HyperchargeDataSource {
    func judgeHypercharge(_ hypercharge: String) -> Bool
    func addHyperchargeArray(_ hypercharge: String)
    func removeHyperchargeArray(_ hypercharge: String)
}

class HyperchargeDataSourceImpl: HyperchargeDataSource {
    let key = "hyperchargeArray"
    
    func judgeHypercharge(_ hypercharge: String) -> Bool {
        let array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if array.contains(hypercharge) {
            return true
        } else {
            return false
        }
    }
    
    func addHyperchargeArray(_ hypercharge: String) {
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if !array.contains(hypercharge) {
            array.append(hypercharge)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
    
    func removeHyperchargeArray(_ hypercharge: String) {
        var array = UserDefaults.standard.stringArray(forKey: key) ?? []
        
        if let index = array.firstIndex(of: hypercharge) {
            array.remove(at: index)
            UserDefaults.standard.set(array, forKey: key)
        }
    }
}
