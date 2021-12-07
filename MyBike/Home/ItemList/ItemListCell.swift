//
//  BikeView.swift
//  MyBike
//
//  Created by Aung Ko Min on 27/10/21.
//

import SwiftUI

struct ItemListCell: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        HStack {
            ItemImageView(itemViewModel.item.images.firstImage, .medium)
            VStack(alignment: .leading, spacing: 8) {
                Text(itemViewModel.item.title.capitalized)
                    .textStyle(style: .title_headline)
                    .foregroundColor(.steam_gold)
                
                HStack {
                    Text(itemViewModel.price)
                        .textStyle(style: .title_title)
                    Spacer()
                    Text(itemViewModel.item.condition.description)
                        .textStyle(style: .link_small)
                }
                
                SellerInfoLabel(itemViewModel)
                
                HStack {
                    ItemFavouritesLabel(itemViewModel)
                    ItemViewsLabel(itemViewModel)
                    
                    Spacer()
                    Text(itemViewModel.item.date_added)
                        .textStyle(style: .link_small)
                    
                }
                .foregroundColor(.secondary)
            }
            .contextMenu{ ItemContextMenu(itemViewModel: itemViewModel) }
            
        }
        .tapToPush(ItemDetailView(itemViewModel: itemViewModel).anyView)
    }
}
