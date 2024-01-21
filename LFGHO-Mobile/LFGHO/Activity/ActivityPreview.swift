//
//  ActivityPreview.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import SwiftUI

struct ActivityPreview: View {
    var activity: Activity
    
    var body: some View {
        HStack(spacing: 10) {
            Image(activity.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .cornerRadius(50)
            
            VStack(alignment: .leading) {
                Text(activity.title)
                
                (Text(activity.group) + Text(" • ") + Text(activity.date))
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        
        }
    }
}

#Preview {
    ActivityPreview(activity: activities[0])
}
