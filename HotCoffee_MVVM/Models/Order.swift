//
//  Order.swift
//  HotCoffee_MVVM
//
//  Created by Willy Hsu on 2025/3/4.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable{
    case espresso
    case latte
    case cappuccino
    case americano
    case macchiato
    case mocha
    case flatWhite
    case cortado
    case lungo
    case ristretto
}

enum CoffeeSize: String, Codable,CaseIterable{
    case small
    case medium
    case large
}

struct Order: Codable{
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
