//
//  PostCellViewModel.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import Foundation

struct PostCellViewModel {
    var post: Post
    
    var companyNameLabel: TextViewModel {
        return TextViewModel(text: post.user.company.name, color: .primary, font: .bold(20), alignment: .left, numberOfLines: 1)
    }
    
    var userNameLabel: TextViewModel {
        return TextViewModel(text: post.user.name, color: .secondary, font: .medium(14), alignment: .left, numberOfLines: 1)
    }
    
    var titleLabel: TextViewModel {
        return TextViewModel(text: post.title, color: .primary, font: .bold(16), alignment: .left, numberOfLines: 1)
    }
    
    var bodyLabel: TextViewModel {
        return TextViewModel(text: post.body, color: .secondary, font: .regular(12), alignment: .left, numberOfLines: 1)
    }
}
