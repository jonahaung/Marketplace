//
//  SearchType.swift
//  MyBike
//
//  Created by Aung Ko Min on 8/12/21.
//

import Foundation
import FirebaseFirestore

enum SearchType {
    
    case TitleSimilier(String)
    case Title(String)
    case Keywords([String])
    case Category(Category)
    case Condition(Item.Condition)
    case Seller(String)
    case UserItem(Person)
    case Similier(Item)
    case Address(AddressType)
}

extension SearchType {
    enum AddressType {
        case state(String)
        case township(String)
        
        var description: String {
            switch self {
            case .state(let string):
                return string
            case .township(let string):
                return string
            }
        }
    }
}

extension SearchType {
    
    func apply(for query: inout Query) {
        switch self {
        case .Title(let string):
            query = query.whereField("title", isEqualTo: string.lowercased())
        case .TitleSimilier(let string):
            let string = string.lowercased()
            query = query.whereField("title", isGreaterThanOrEqualTo: string)
                .whereField("title", isLessThanOrEqualTo: string + "~")
        case .Keywords(var strings):
            strings = strings.map{$0.lowercased()}.unique
            query = query.whereField("keywords", arrayContainsAny: strings)
        case .Category(let category):
            query = query.whereField("category.title", isEqualTo: category.title)
        case .Condition(let condition):
            query = query.whereField("condition", isEqualTo: condition.rawValue)
        case .Seller(let string):
            query = query.whereField("seller.userName", isEqualTo: string.lowercased())
        case .UserItem(let person):
            query = query.whereField("seller.userName", isGreaterThanOrEqualTo: person.userName.lowercased())
        case .Similier(let item):
            query = query.whereField("category.title", isEqualTo: item.category.title).whereField("keywords", arrayContainsAny: item.keywords.map{$0.lowercased()})
        case .Address(let addressType):
            switch addressType {
            case .state(let string):
                query = query.whereField("address.state", isEqualTo: string)
            case .township(let string):
                query = query.whereField("address.township", isEqualTo: string)
            }
        }
    }
}

extension SearchType {
    var description: String {
        switch self {
        case .Title(let string):
            return string.capitalized
        case .Keywords(_):
            return "Keywords"
        case .Category(let category):
            return category.title.capitalized
        case .Condition(let condition):
            return condition.description
        case .Seller(let string):
            return string
        case .UserItem(let person):
            return person.userName
        case .Similier(_):
            return "Similier Items"
        case .Address(let type):
            return type.description
        case .TitleSimilier(_):
            return "Similier Items"
        }
    }
    var id: String {
        switch self {
        case .Title(let string):
            return string.capitalized
        case .Keywords(let array):
            return array.joined(separator: " ")
        case .Category(let category):
            return category.title
        case .Condition(let condition):
            return condition.description
        case .Seller(let string):
            return string
        case .UserItem(let person):
            return "useritem" + (person.id ?? "person")
        case .Similier(let item):
            return "Similier" + (item.id ?? "")
        case .Address(let type):
            return type.description
        case .TitleSimilier(let item):
            return "Title Similier" + item.id
        }
    }
}

extension SearchType: Equatable, Hashable {
    
    static func == (lhs: SearchType, rhs: SearchType) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
