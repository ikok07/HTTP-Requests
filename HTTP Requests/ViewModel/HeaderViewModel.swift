//
//  HeaderViewModel.swift
//  HTTP Requests
//
//  Created by Kaloyan Petkov on 19.07.23.
//

import SwiftUI

struct HeaderViewModel: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(.title))
            .fontWeight(.bold)
    }
}

struct HeaderViewModel_Previews: PreviewProvider {
    static var previews: some View {
        HeaderViewModel(title: "Sample title")
    }
}
