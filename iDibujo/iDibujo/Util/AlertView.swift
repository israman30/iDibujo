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
    case delete(_ okAction: () -> Void?, cancel: () -> Void?)
    case failure(_ failure: () -> Void?)
    
    var title: String {
        switch self {
        case .delete:
            return "¡Listo!"
        case .failure:
            return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .delete:
            return "Are you deleting your art?"
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
        case .delete(let okAction, let cancel):
            Button("Yes", role: .destructive) {
                okAction()
            }
            Button("No", role: .cancel) {
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
