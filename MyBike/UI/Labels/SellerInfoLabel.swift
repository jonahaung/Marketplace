//
//  SellerInfoLabel.swift
//  MyBike
//
//  Created by Aung Ko Min on 3/12/21.
//

import SwiftUI

struct SellerInfoLabel: View {
    
    @ObservedObject private var itemViewModel: ItemViewModel
    
    init(_ _itemViewModel: ItemViewModel) {
        itemViewModel = _itemViewModel
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            PersonImageView(itemViewModel.item.seller.photoUrl, .tinyPersonImage)
            Text(itemViewModel.item.seller.userName)
                .tapToPush(Text("Person").anyView)
        }
    }
}
