//
//  MultiLineTextView.swift
//  Todilist
//
//  Created by yanchen on 2020/3/11.
//  Copyright © 2020 Wang Sunyechu. All rights reserved.
//

import SwiftUI
import UIKit

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?
    var limitedCharacter: Int

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
//        if uiView.window != nil, !uiView.isFirstResponder {
//            uiView.becomeFirstResponder()
//        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone, limitedCharacter: limitedCharacter)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        var limitedCharacter: Int

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil, limitedCharacter: Int) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
            self.limitedCharacter = limitedCharacter
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            } else{
                // get the current text, or use an empty string if that failed
                let currentText = textView.text ?? ""

                // attempt to read the range they are trying to change, or exit if we can't
                guard let stringRange = Range(range, in: currentText) else { return false }

                // add their new text to the existing text
                let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

                // make sure the result is under 16 characters
                return updatedText.count <= limitedCharacter
            }
            
        }
    }

}

struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?
    private var limitedCharacter: Int

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil, limitedCharacter: Int) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self.limitedCharacter = limitedCharacter
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
        
    }

    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, onDone: onCommit, limitedCharacter: self.limitedCharacter)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .animation(.spring())
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}

#if DEBUG
struct MultilineTextField_Previews: PreviewProvider {
    static var test:String = ""//some very very very long description string to be initially wider than screen"
    static var testBinding = Binding<String>(get: { test }, set: {
//        print("New value: \($0)")
        test = $0 } )

    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Description:")
            MultilineTextField("Enter some text here", text: testBinding, limitedCharacter: 0)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
            Text("Something static here...")
            Spacer()
        }
        .padding()
    }
}
#endif
