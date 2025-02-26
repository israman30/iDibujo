//
//  AlertView.swift
//  iDibujo
//
//  Created by Israel Manzo on 2/26/25.
//  Copyright © 2025 Israel Manzo. All rights reserved.
//

import SwiftUI


protocol AlertProtocol {
    var title: String { get }
    var message: String { get }
    var buttons: AnyView { get }
}

enum AlertComponent: AlertProtocol {
    case success(_ okAction: () -> Void?, cancel: () -> Void)
    case failure(_ failure: () -> Void?)
    
    var title: String {
        switch self {
        case .success:
            return "¡Listo!"
        case .failure:
            return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        }
    }
    
    var buttons: AnyView {
        AnyView(setButtons())
    }
    
    @ViewBuilder
    func setButtons() -> some View {
        switch self {
        case .success(let okAction, let cancel):
            Button("Success") {
                okAction()
            }
            Button("Cancel") {
                cancel()
            }
        case .failure(let failure):
            Button("Faithure") {
                failure()
            }
        }
    }
}

extension View {
    func presentAlert<T: AlertProtocol>(_ alert: Binding<T?>, isPresented: Binding<Bool>) -> some View {
        self.alert(alert.wrappedValue?.title ?? "", isPresented: isPresented, actions: {
            alert.wrappedValue?.buttons
        }, message: {
            Text(alert.wrappedValue?.message ?? "")
        })
    }
}
