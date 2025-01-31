//
//  ContactCardView.swift
//  sos-health
//
//  Created by Gabriel Barbosa da Silva on 23/11/21.
//

import SwiftUI

struct ContactCardView: View {

    @State var name: String
    @State var phoneNumber: String

    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer().frame(maxHeight: 4)
                Text(name)
                    .foregroundColor(.black)
                    .font(.callout)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(maxHeight: 8)
                Text(phoneNumber)
                    .foregroundColor(.black)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack(spacing: 8) {
                    Button(action: {
                        let tel = "imessage://"
                        let formattedString = tel + phoneNumber.removeAllNonNumeric()
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    }) {
                        Image(systemName: "message.fill")
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                    Button(action: {
                        let tel = "tel://"
                        let formattedString = tel + phoneNumber.removeAllNonNumeric()
                        guard let url = URL(string: formattedString) else { return }
                        UIApplication.shared.open(url)
                    }) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }.padding()
        }
        .frame(minWidth: 180, maxHeight: 120, alignment: .leading)
        .background(Color.primary.opacity(0.05))
    }
}
