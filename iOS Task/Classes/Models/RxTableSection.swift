//
//  RxTableSection.swift
//  iOS Task
//
//  Created by Klaudas Jankauskas on 4/1/19.
//  Copyright © 2019 Klaudas Jankauskas. All rights reserved.
//

import RxDataSources

struct RxTableSection<T> {
    var items: [Item]
}

extension RxTableSection: SectionModelType {
    typealias Item = T
    
    init(original: RxTableSection, items: [Item]) {
        self = original
        self.items = items
    }
}
