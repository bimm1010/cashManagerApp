//
//  ModelList.swift
//  CaseManager
//
//  Created by Hoàng Nam on 22/4/25.
//

import Foundation
import SwiftUICore

struct Category: Identifiable {
    let id: Int
    let name: String
    let image: String
    let color: Color
}

let categories: [Category] = [
    .init(id: 0, name: "Ăn Uống", image: "eat", color: .orange),
    .init(id: 1, name: "Chi tiêu", image: "wash", color: .green),
    .init(id: 2, name: "Quần áo", image: "Clothes", color: .purple),
    .init(id: 3, name: "Mỹ Phẩm", image: "Makeup", color: .pink),
    .init(id: 4, name: "Giao Lưu", image: "Playmoney", color: .yellow),
    .init(id: 5, name: "Y tế", image: "pharmacy", color: .green),
    .init(id: 6, name: "Giáo dục", image: "Study", color: .red),
    .init(id: 7, name: "Tiền Điện", image: "Electricmoney", color: .blue),
    .init(id: 8, name: "Đi lại", image: "Goto", color: .brown),
    .init(id: 9, name: "Liên lạc", image: "Phonemoney", color: .black),
    .init(id: 10, name: "Tiền nhà", image: "Homemoney", color: .orange),
    .init(id: 11, name: "Internet", image: "Internetmoney", color: .pink),
]

let categories2: [Category] = [
    .init(id: 0, name: "Tiền lương", image: "MonthCash", color: .green),
    .init(id: 1, name: "Tiền phụ cấp", image: "SaveCash", color: .orange),
    .init(id: 2, name: "Tiền Thưởng", image: "GiftCash", color: .red),
    .init(id: 3, name: "Thu nhập phụ", image: "CashPlus", color: .blue),
    .init(id: 4, name: "Đầu tư", image: "CashX", color: .cyan),
    .init(id: 5, name: "Thu nhập khác", image: "PlusMoney", color: .pink),
]
