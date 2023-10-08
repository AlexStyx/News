//
//  String.swift
//  News
//
//  Created by Александр Бисеров on 08.10.2023.
//

import Foundation

extension String? {
    var orEmpty: String {
        switch self {
        case .none:
            return ""
        case .some(let val):
            return val
        }
    }
}
