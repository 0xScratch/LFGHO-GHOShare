//
//  GroupViewModel.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import SwiftUI
import Combine

class GroupViewModel: ObservableObject {
    
    @Published var groups: [Group] = []
    @Published var groups1: [Group] = []
    
    init() {
        groups = [
            Group(name: "Boston Trip", imageUrl: "group_img", memberCount: 2.0, owedAmount: 47.50, open: false)
        ]
        
        groups1 = [
            Group(name: "Boston Trip", imageUrl: "group_img", memberCount: 2.0, owedAmount: 47.50, open: false),
            Group(name: "London Getaway", imageUrl: "group_img", memberCount: 3.0, owedAmount: 180.0, open: true)
        ]
    }
    
    func addGroup(name: String, imageUrl: String, memberCount: Double, owedAmount: Double, open: Bool) {
        let newGroup = Group(name: name, imageUrl: imageUrl, memberCount: memberCount, owedAmount: owedAmount, open: open)
        // Make sure to dispatch to the main thread as you're updating the UI
        DispatchQueue.main.async {
            self.groups.append(newGroup)
        }
    }
}
