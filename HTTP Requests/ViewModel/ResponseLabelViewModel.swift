//
//  ResponseLabelViewModel.swift
//  HTTP Requests
//
//  Created by Kaloyan Petkov on 19.07.23.
//

import SwiftUI

struct ResponseLabelViewModel: View {
    
    @State var responseData: String
    
    var body: some View {
        Text(responseData)
            .foregroundColor(.gray)
            .padding(10)
            .frame(maxWidth: .infinity)
            .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 1)
            )
    }
}

struct ResponseLabelViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ResponseLabelViewModel(responseData: "Response text label test")
    }
}
