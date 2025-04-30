//
//  AlertView.swift
//  iDibujo Mac
//
//  Created by Israel Manzo on 4/30/25.
//

import SwiftUI

protocol AlertProtocol {
    var title: String { get }
    var message: String { get }
    var buttons: AnyView { get }
}

enum AlertMessage: AlertProtocol {
    case delete(_ okAction: () -> Void?, cancel: () -> Void?)
    case error(_ failure: () -> Void?)
    
    var title: String {
        switch self {
        case .delete:
            return "Done"
        case .error:
            return "Error"
        }
    }
    
    var message: String {
        switch self {
        case .delete:
            return "Are you deleting your art?"
        case .error:
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
        case .error(let failure):
            Button("Failure") {
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
