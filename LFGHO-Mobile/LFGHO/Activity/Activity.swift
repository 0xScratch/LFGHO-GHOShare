//
//  Activity.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import SwiftUI

struct Activity: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var group: String
    var date: String
    var imageUrl: String
}

var activities: [Activity] = [
    Activity(title: "Jeevan created the Boston Trip group", group: "Boston Trip", date: "20.1.2024", imageUrl: "icon2"),
    Activity(title: "Mark paid $12 (12 GHO) towards London Getaway", group: "London Getaway", date: "18.1.2024", imageUrl: "icon3"),
    Activity(title: "Theo left London Getaway", group: "London Getaway", date: "17.1.2024", imageUrl: "icon4"),
]
