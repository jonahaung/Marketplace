//
//  ItemKeywordsRow.swift
//  MyBike
//
//  Created by Aung Ko Min on 29/11/21.
//

import SwiftUI

struct ItemKeywordsSection: View {
    
    @StateObject var itemViewModel: ItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(itemViewModel.item.keywords) { keyword in
                        RoundedBadge(text: keyword, color: .gray)
                            .foregroundColor(.white)
                            .tapToPushItemsList(.search(.Keywords(itemViewModel.item.keywords)))
                            
                    }
                }.padding(.leading)
            }
        }
    }
}
