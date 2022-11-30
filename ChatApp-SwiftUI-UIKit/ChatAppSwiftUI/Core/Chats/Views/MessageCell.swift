//
//  MessageCell.swift
//  ChatAppSwiftUI
//
//  Created by Baris OZGEN on 30.11.2022.
//

import SwiftUI

struct MessageCell: View {
    @State var messageValue: String = "herehere here herei herehere here here"
    @State var dateValue: String = "07:29"
    @State var nameValue: String = "Barış Özgen"
    @State var isMine = true
    @State var isLast = true
    @State var isGroup = true
    @State var isRead = true
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                // picture
                if !isMine && isLast && isGroup {
                    imageView
                }
                // message view
                VStack(alignment: .leading, spacing: 0){
                    if isGroup && !isMine {
                        nameView
                    }
                    Text(messageValue)
                    dateView
                }
                .padding(EdgeInsets(top: 7, leading: 4, bottom: 4, trailing: 2))
                .background(isMine ?
                            Color.theme.balloonMineColor
                            :Color.theme.balloonOtherColor)
                .clipShape(BubbleShape(isMine: isMine, isLast: isLast))
                .shadow(color: .black.opacity(0.29), radius: 2, x:0, y: 2)
            }
            .frame(maxWidth: 292)
        }
        .frame(maxWidth: 429, alignment: isMine ? .trailing : .leading)
        
    }
}

extension MessageCell {
    private var imageView: some View {
        Image(systemName: "person.fill")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 32, height: 32)
            .background(Color.theme.pageBackgroundColor)
            .clipShape(Circle())
    }
    private var nameView: some View {
        HStack{
            Text(nameValue)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.brown)
                .padding(.vertical, 2)
            Spacer()
        }
    }
    private var dateView: some View {
        HStack{
            Spacer()
            Text(dateValue)
                .font(.caption2)
                .foregroundColor(.gray)
            
            if isMine {
                Image(systemName: "checkmark")
                    .foregroundColor(isRead ? .green : .gray)
                Image(systemName: "checkmark")
                    .foregroundColor(isRead ? .green : .gray)
                    .padding(.leading, -22)
            }
            
        }
        .padding(.horizontal, 7)
    }

    struct BubbleShape: Shape {
        var isMine = false
        var isLast = false
        
        func path(in rect: CGRect) -> Path {
            let lastBubble : UIRectCorner = [.topLeft, .topRight, isMine ? .bottomLeft : .bottomRight]
            
            let normalBubble : UIRectCorner = [.allCorners]
            
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: isLast ? lastBubble : normalBubble, cornerRadii: CGSize(width: 14, height: 14))
            
            return Path(path.cgPath)
        }
    }
}
struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell()
    }
}
