//
//  UserViewViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 7/23/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation

struct UserViewViewModel {
    let post: Post
    
    var imageView: ImageViewModel {
        return ImageViewModel(url: post.user.photoUrl, contentMode: .scaleAspectFill)
    }
    
    var nameLabel: TextViewModel {
        return TextViewModel(text: post.user.name, color: .primary, font: .bold(20))
    }
    
    var companyNameLabel: TextViewModel {
        return TextViewModel(text: post.user.company.name, color: .secondary, font: .bold(16))
    }
    
    var emailTextView: TextViewViewModel {
        return TextViewViewModel(text: post.user.email, textColor: .primary, font: .regular(12), dataType: .link)
    }
    
    var addressLabel: TextViewModel {
        let street = post.user.address.street
        let suite = post.user.address.suite
        let city = post.user.address.city
        let zipcode = post.user.address.zipcode
        let address = [street, suite, city, zipcode].joined(separator: ", ")
        
        return TextViewModel(text: "📍" + address, color: .primary, font: .regular(12), alignment: .left)
    }
    
    var phoneTextView: TextViewViewModel {
        return TextViewViewModel(text: post.user.phone, textColor: .primary, font: .regular(12), dataType: .phoneNumber)
    }
}
